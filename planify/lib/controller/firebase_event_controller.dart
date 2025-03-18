import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../view/Home&EventDetails/eventDetails.dart';

class FirebaseController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();

  final TextEditingController eventCategoryController = TextEditingController();
  final TextEditingController organizerNameController = TextEditingController();
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventDateController = TextEditingController();
  final TextEditingController eventLocationController = TextEditingController();
  final TextEditingController ticketPriceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  var selectedImages = <File>[].obs; 
  var events = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  /// PICK IMAGES
  Future<void> pickImages() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImages.assign(File(image.path)); // ✅ Only one image allowed
    }
  }

  /// UPLOAD IMAGE AND REQUIRED DATA
  Future<void> uploadImage() async {
    if (selectedImages.isEmpty) {
      Get.snackbar("Error", "You must select an image.");
      return;
    }

    if (eventNameController.text.trim().isEmpty ||
        eventDateController.text.trim().isEmpty ||
        eventLocationController.text.trim().isEmpty ||
        ticketPriceController.text.trim().isEmpty ||
        organizerNameController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty) {
      Get.snackbar("Error", "All fields are required!");
      return;
    }

    try {
      String imageUrl = "";

      File image = selectedImages.first;
      final storageRef = storage.ref().child(
          "events/${eventNameController.text.trim()}/${image.path.split('/').last}");
      await storageRef.putFile(image);
      imageUrl = await storageRef.getDownloadURL();

      Map<String, dynamic> eventData = {
        "title": eventNameController.text,
        "date": eventDateController.text,
        "location": eventLocationController.text,
        "price": ticketPriceController.text,
        "organizer": organizerNameController.text,
        "description": descriptionController.text,
        "images": [imageUrl], // ✅ Store as list
      };

      await firestore.collection("events").add(eventData);
      fetchEvents();
      clearFields();
      Get.back();
    } catch (e) {
      log("❌ Error uploading image: $e");
      Get.snackbar("Error", "Failed to upload image");
    }
  }

  void clearFields() {
    eventCategoryController.clear();
    organizerNameController.clear();
    eventNameController.clear();
    eventDateController.clear();
    eventLocationController.clear();
    ticketPriceController.clear();
    descriptionController.clear();
    selectedImages.clear();
  }

  void fetchEvents() {
    firestore.collection('events').snapshots().listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        events.value = snapshot.docs.map((doc) => doc.data()).toList();
      }
    });
  }

  void searchEvent(String query) {
    if (query.isEmpty) {
      fetchEvents();
    } else {
      events.value = events
          .where((event) => event["title"]
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
  }

  void navigateToEventDetails(int index) {
    Get.to(() => EventDetailsScreen(eventIndex: index));
  }
}
