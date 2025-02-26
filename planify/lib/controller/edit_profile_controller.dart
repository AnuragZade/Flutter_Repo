import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class EditProfileController extends GetxController {
  var profileImage = Rx<File?>(null);
  var username = "".obs;
  var about = "".obs;
  final ImagePicker picker = ImagePicker();

  late TextEditingController usernameController;
  late TextEditingController aboutController;

  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController(text: username.value);
    aboutController = TextEditingController(text: about.value);
  }

  // Function to pick an image
  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage.value = File(image.path);
    }
  }

  // Function to update profile
  void updateProfile() {
    username.value = usernameController.text;
    about.value = aboutController.text;
    log("Profile Updated: ${username.value}, ${about.value}");
  }

  @override
  void onClose() {
    usernameController.dispose();
    aboutController.dispose();
    super.onClose();
  }
}
