import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planify/view/Home&EventDetails/homeScreen.dart';

class TicketController extends GetxController {
  var ticketDownloaded = false.obs;

  void downloadTicket() {
    ticketDownloaded.value = true;
    Get.snackbar(
      "Success",
      "Ticket downloaded successfully",
      icon: const Icon(Icons.check_circle, color: Colors.green),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => HomeScreen());
    });
  }
}
