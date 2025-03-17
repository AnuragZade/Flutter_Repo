import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:planify/view/Home&EventDetails/homeScreen.dart';
import 'package:planify/view/navBar.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isLoading = false.obs;
void signInWithEmail() async {
  try {
    isLoading.value = true;

    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    isLoading.value = false;

    // ✅ Navigate to the bottom navigation bar after successful login
    Get.offAll(() =>  const PersistanrnavCustom(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 500));
  } catch (e) {
    isLoading.value = false;
    Get.snackbar("Error", e.toString(),
        backgroundColor: Colors.red, colorText: Colors.white);
  }
}


  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await _auth.signInWithCredential(credential);
      Get.offAll(() => HomeScreen());
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to sign in with Google",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithFacebook() async {
    // Add Facebook login logic here (if needed)
    Get.snackbar(
      "Error",
      "Facebook login not implemented yet",
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
