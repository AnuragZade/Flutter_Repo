import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var organizerName = ''.obs;
  var eventName = ''.obs;
  var eventDate = ''.obs;
  var ticketPrice = ''.obs;
  var address = ''.obs;
  var description = ''.obs;
  var selectedImage = File('').obs;

  TextEditingController organizerNameController = TextEditingController();
  TextEditingController eventNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController ticketPriceController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void updateProfile() {
    organizerName.value = organizerNameController.text;
    eventName.value = eventNameController.text;
    eventDate.value = dateController.text;
    ticketPrice.value = ticketPriceController.text;
    address.value = addressController.text;
    description.value = descriptionController.text;
  }
}
