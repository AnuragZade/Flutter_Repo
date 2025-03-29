import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:planify/controller/firebase_event_controller.dart';
import 'package:planify/view/Home&EventDetails/homeScreen.dart';

class TicketScreen extends StatelessWidget {
  TicketScreen({super.key});

  final FirebaseController firebaseController = Get.put(FirebaseController());
  final ScreenshotController screenshotController =
      ScreenshotController(); // Initialize Screenshot Controller

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Tickets",
          style: GoogleFonts.ptSans(
            fontSize: 27.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurpleAccent, Colors.black87],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 24.sp),
          onPressed: () => Get.off(() => HomeScreen()),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Obx(() {
          if (firebaseController.events.isEmpty) {
            return Center(
              child: Text(
                "No events found",
                style: GoogleFonts.roboto(fontSize: 18.sp, color: Colors.white),
              ),
            );
          }

          final event = firebaseController.events.first;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              // Wrap the ticket container with Screenshot widget
              Screenshot(
                controller: screenshotController,
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.deepPurpleAccent, Colors.black87],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 10.r,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.r),
                          topRight: Radius.circular(15.r),
                        ),
                        child: Image.network(
                          "https://img.freepik.com/premium-vector/ticket-logo_9850-381.jpg",
                          height: 180.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            detailRow("🎭 Event", event["title"] ?? "Unknown"),
                            SizedBox(height: 10.h),
                            detailRow("📅 Date", event["date"] ?? "Not Set"),
                            SizedBox(height: 10.h),
                            detailRow("⏰ Time", "10:00 PM"),
                            SizedBox(height: 10.h),
                            detailRow(
                                "📍 Venue", event["location"] ?? "Unknown"),
                            SizedBox(height: 10.h),
                            detailRow(
                                "🎤 Organizer", event["organizer"] ?? "N/A"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              // 📥 Download Button with Screenshot Functionality
              Container(
                margin: EdgeInsets.only(top: 65.h, left: 25.w, right: 25.w),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.deepPurpleAccent, Colors.black87],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await captureAndSaveTicket();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 60.w),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  label: Text(
                    "📥 DOWNLOAD IMAGE",
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          );
        }),
      ),
    );
  }

  // Function to Capture and Save Ticket
  Future<void> captureAndSaveTicket() async {
    try {
      Uint8List? imageBytes = await screenshotController.capture();
      if (imageBytes == null) return;

      // Get device storage path
      final directory = await getApplicationDocumentsDirectory();
      final filePath = "${directory.path}/ticket.png";

      // Save file
      File file = File(filePath);
      await file.writeAsBytes(imageBytes);

      // Show success message
      Get.snackbar(
        "Success",
        "Ticket saved successfully!",
        icon: const Icon(Icons.check_circle, color: Colors.green),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.black87,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: EdgeInsets.all(10.w),
      );
    } catch (e) {
      print("Error saving ticket: $e");
      Get.snackbar(
        "Error",
        "Failed to save the ticket!",
        icon: const Icon(Icons.error, color: Colors.red),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.black87,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: EdgeInsets.all(10.w),
      );
    }
  }

  Widget detailRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: 14.sp,
            color: Colors.white70,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          value,
          style: GoogleFonts.roboto(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
