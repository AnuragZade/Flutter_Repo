import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../view/Home&EventDetails/homeScreen.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email.isNotEmpty && password.isNotEmpty) {
      Get.to(() => HomeScreen());
    } else {
      Get.snackbar(
        "Error",
        "Please enter email and password",
        colorText: Colors.white,
        backgroundColor: Colors.red.withOpacity(0.8),
      );
    }
  }
}
