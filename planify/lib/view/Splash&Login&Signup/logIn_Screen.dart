import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planify/view/Splash&Login&Signup/logIn_Screen.dart';
import 'package:planify/view/Splash&Login&Signup/resetPasswordScreen.dart';
import 'package:planify/view/Splash&Login&Signup/signUp_Screen.dart';
import 'package:planify/view/navBar.dart';

import '../../controller/logInController.dart';
import '../../controller/nav_controller.dart';

class LogInScreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  final NavController navController = Get.put(NavController());

  LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 120.h,
                          width: 120.w,
                          child: Image.asset("assets/images/AppLogo.png"),
                        ),
                        Text(
                          "PLANIFY",
                          style: GoogleFonts.alegreya(
                              fontSize: 40.sp, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text("Sign in",
                      style: GoogleFonts.poppins(
                          fontSize: 30.sp, fontWeight: FontWeight.w600)),
                  SizedBox(height: 20.h),
                  _buildTextField(loginController.emailController,
                      "abc@email.com", Icons.email_outlined),
                  SizedBox(height: 20.h),
                  _buildTextField(loginController.passwordController,
                      "Your password", Icons.lock_outline,
                      isPassword: true),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () =>
                          Get.to(() => const ForgotPasswordScreen()),
                      child: Text("Forgot Password ?",
                          style: GoogleFonts.ptSans(
                              fontSize: 17.sp, fontWeight: FontWeight.w700)),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  _buildSignInButton(),
                  SizedBox(height: 20.h),
                  Center(
                      child: Text("OR",
                          style: GoogleFonts.b612(
                              fontSize: 20.sp, fontWeight: FontWeight.w500))),
                  SizedBox(height: 30.h),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(const PersistanrnavCustom());
                    },
                    child: _buildSocialButton(
                        "assets/images/GOOGLE.png", "Login with Google"),
                  ),
                  _buildSocialButton(
                      "assets/images/FACEBOOK.png", "Login with Facebook"),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",
                          style: GoogleFonts.poppins(fontSize: 17.sp)),
                      TextButton(
                        onPressed: () => Get.to(() => SignUpScreen()),
                        child: Text("Sign up",
                            style: GoogleFonts.poppins(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(255, 93, 58, 153),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hint, IconData icon,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Colors.black)),
      ),
    );
  }
Widget _buildSignInButton() {
  return Obx(() {
    return GestureDetector(
      onTap: () => loginController.signInWithEmail(), // ✅ Controller handles navigation
      child: Container(
        height: 60.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: const Color.fromARGB(255, 93, 58, 153),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1.5,
              blurRadius: 5,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Center(
          child: loginController.isLoading.value
              ? const CircularProgressIndicator(color: Colors.white)
              : Text("SIGN IN",
                  style: GoogleFonts.ptSans(
                      fontSize: 27.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
        ),
      ),
    );
  });
}

  Widget _buildSocialButton(String imagePath, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 50.w),
      child: Container(
        height: 40.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 103, 101, 100).withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 30.h,
            ),
            SizedBox(width: 20.w),
            Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 17.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
