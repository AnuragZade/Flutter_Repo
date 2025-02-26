import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'logIn_Screen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>  LogInScreen(),
            ),
          );
        },
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/AppLogo.png",
              height: 200,
            ),
            Text(
              "PLANIFY",
              style: GoogleFonts.daiBannaSil(
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: const Color.fromARGB(255, 82, 51, 134),
              ),
            )
          ],
        )),
      ),
    );
  }
}
