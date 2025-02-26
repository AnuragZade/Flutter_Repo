// import 'package:get/get.dart';

// class ProfileController extends GetxController {
//   var organizerName = ''.obs;
//   var eventName = ''.obs;
//   var eventDate = ''.obs;
//   var ticketPrice = ''.obs;
//   var address = ''.obs;
//   var description = ''.obs;

//   void updateProfile(String organizer, String event, String date, String price, String addr, String desc) {
//     organizerName.value = organizer;
//     eventName.value = event;
//     eventDate.value = date;
//     ticketPrice.value = price;
//     address.value = addr;
//     description.value = desc;
//   }
// }


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
