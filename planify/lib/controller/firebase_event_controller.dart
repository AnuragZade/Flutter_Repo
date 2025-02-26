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


// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import '../view/Home&EventDetails/eventDetails.dart';

// class EventsTabController extends GetxController {
//   var events = <Map<String, String>>[].obs;
//   var filteredEvents = <Map<String, String>>[].obs; // Add this for search
//   var selectedImage = Rx<File?>(null);

//   final TextEditingController eventCategoryController = TextEditingController();
//   final TextEditingController organizerNameController = TextEditingController();
//   final TextEditingController eventNameController = TextEditingController();
//   final TextEditingController eventDateController = TextEditingController();
//   final TextEditingController eventLocationController = TextEditingController();
//   final TextEditingController ticketPriceController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();

//   final ImagePicker picker = ImagePicker();

//   @override
//   void onInit() {
//     super.onInit();
//     _loadHardcodedEvents(); // Load initial hardcoded events
//     filteredEvents.assignAll(events); // Initially show all events
//   }

//   void _loadHardcodedEvents() {
//     events.addAll([
//       {
//         "title": "International Band Music Concert",
//         "date": "12-15 October, 22",
//         "location": "ABC Avenue, Dhaka",
//         "price": "₹500",
//         "organizer": "Anurag Zade",
//         "description": "An amazing international band performing live!",
//         "image": "assets/images/event.jpg",
//       },
//       {
//         "title": "Band Music Concert",
//         "date": "15 Nov, 25",
//         "location": "XYZ Avenue, Pune",
//         "price": "₹800",
//         "organizer": "Ayush",
//         "description": "An exciting music concert in Pune!",
//         "image": "assets/images/event.jpg",
//       },
//     ]);
//   }

//   Future<void> pickImage() async {
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       selectedImage.value = File(image.path);
//     }
//   }

//   void addEvent() {
//     if (eventCategoryController.text.isNotEmpty &&
//         eventNameController.text.isNotEmpty &&
//         eventDateController.text.isNotEmpty &&
//         eventLocationController.text.isNotEmpty &&
//         ticketPriceController.text.isNotEmpty &&
//         organizerNameController.text.isNotEmpty &&
//         descriptionController.text.isNotEmpty) {
//       events.add({
//         "category": eventCategoryController.text,
//         "title": eventNameController.text,
//         "date": eventDateController.text,
//         "location": eventLocationController.text,
//         "price": ticketPriceController.text,
//         "organizer": organizerNameController.text,
//         "description": descriptionController.text,
//         "image": selectedImage.value?.path ?? "",
//       });

//       filteredEvents.assignAll(events); // Update filtered list

//       // Clear fields after adding event
//       eventCategoryController.clear();
//       organizerNameController.clear();
//       eventNameController.clear();
//       eventDateController.clear();
//       eventLocationController.clear();
//       ticketPriceController.clear();
//       descriptionController.clear();
//       selectedImage.value = null;
//       Get.back();
//     }
//   }

//   void searchEvent(String query) {
//     if (query.isEmpty) {
//       filteredEvents.assignAll(events);
//     } else {
//       filteredEvents.assignAll(
//         events.where((event) =>
//             event["title"]!.toLowerCase().contains(query.toLowerCase())),
//       );
//     }
//   }

//   void navigateToEventDetails(int index) {
//     Get.to(() => EventDetailsScreen(eventIndex: index));
//   }

//   @override
//   void onClose() {
//     organizerNameController.dispose();
//     eventNameController.dispose();
//     eventDateController.dispose();
//     eventLocationController.dispose();
//     ticketPriceController.dispose();
//     descriptionController.dispose();
//     super.onClose();
//   }
// }
