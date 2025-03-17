import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/signUpController.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 50.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Text(
                  "Sign up",
                  style: GoogleFonts.poppins(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              buildTextField(controller.nameController, "Full Name",
                  Icons.person_outlined),
              buildTextField(controller.emailController, "abc@email.com",
                  Icons.email_outlined),
              buildTextField(controller.passwordController, "Your password",
                  Icons.lock_outline,
                  obscureText: true),
              buildTextField(controller.confirmPasswordController,
                  "Confirm your password", Icons.lock_outline,
                  obscureText: true),
              SizedBox(height: 30.h),
              GestureDetector(
                onTap: controller.signUp,
                child: Container(
                  height: 60.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: const Color.fromARGB(255, 93, 58, 153),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 103, 101, 100)
                            .withOpacity(0.5),
                        spreadRadius: 1.5,
                        blurRadius: 5,
                        offset: const Offset(0, 7),
                      )
                    ],
                  ),
                  child: Obx(() {
                    return controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : GestureDetector(
                            onTap: controller.signUp,
                            child: Container(
                              height: 60.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                color: const Color.fromARGB(255, 93, 58, 153),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 103, 101, 100)
                                            .withOpacity(0.5),
                                    spreadRadius: 1.5,
                                    blurRadius: 5,
                                    offset: const Offset(0, 7),
                                  )
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  "SIGN UP",
                                  style: GoogleFonts.ptSans(
                                    fontSize: 27.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                  }),
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  "OR",
                  style: GoogleFonts.b612(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 107, 105, 105),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              buildSocialLoginButton(
                  "assets/images/GOOGLE.png", "Login with Google"),
              buildSocialLoginButton(
                  "assets/images/FACEBOOK.png", "Login with Facebook"),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: GoogleFonts.poppins(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Text(
                      " Sign in",
                      style: GoogleFonts.poppins(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 93, 58, 153),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      TextEditingController controller, String hint, IconData icon,
      {bool obscureText = false}) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(117, 115, 115, 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Colors.black),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget buildSocialLoginButton(String imagePath, String text) {
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
