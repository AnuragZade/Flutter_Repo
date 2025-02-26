import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planify/view/Splash&Login&Signup/logIn_Screen.dart';

class PasswordResetDoneScreen extends StatefulWidget {
  const PasswordResetDoneScreen({super.key});

  @override
  State<PasswordResetDoneScreen> createState() =>
      _PasswordResetDoneScreenState();
}

class _PasswordResetDoneScreenState extends State<PasswordResetDoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: Colors.green,
                ),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                "assets/images/tick.png",
                color: Colors.green,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Successful",
            style: GoogleFonts.ptSans(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Congratulations! Your password has",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          Text(
            "been changed. Click continue to login",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => LogInScreen(),
                ),
                (Route<dynamic> route) =>
                    false, // This ensures all routes are removed
              );
            },
            child: Container(
              height: 60,
              width: 350,
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
                ],
              ),
              child: Center(
                child: Text(
                  "CONTINUE",
                  style: GoogleFonts.ptSans(
                    fontSize: 27,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
