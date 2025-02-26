import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planify/view/Splash&Login&Signup/passwordResetDone.dart';
import 'package:planify/view/Splash&Login&Signup/verificationScreen.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State {
  @override
  Widget build(BuildContext context) {
    TextEditingController _newPasswordPasswordController =
        TextEditingController();
    TextEditingController _confrimNewPasswordPasswordController =
        TextEditingController();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: const Icon(Icons.arrow_back_ios),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Set a new password",
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Create a new password. Ensure it differ from previous ones for security",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextField(
                controller: _newPasswordPasswordController,
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.remove_red_eye_outlined,
                  ),
                  label: const Text(
                    "Enter your new password",
                  ),
                  hintStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(117, 115, 115, 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _newPasswordPasswordController,
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                  label: const Text(
                    "Re-enter password",
                  ),
                  hintStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(117, 115, 115, 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 30, bottom: 30, left: 30, right: 30),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PasswordResetDoneScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 60,
                    width: 400,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color.fromARGB(255, 93, 58, 153),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 103, 101, 100)
                                .withOpacity(0.5),
                            spreadRadius: 1.5,
                            blurRadius: 5,
                            offset: const Offset(0, 7),
                          )
                        ]),
                    child: Center(
                      child: Text(
                        "SEND",
                        style: GoogleFonts.ptSans(
                          fontSize: 27,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
