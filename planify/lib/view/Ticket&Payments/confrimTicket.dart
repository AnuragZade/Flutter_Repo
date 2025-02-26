import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:planify/controller/eventDeatilsController.dart';
import 'package:planify/view/Home&EventDetails/homeScreen.dart';

class TicketScreen extends StatelessWidget {
  TicketScreen({super.key});

  final EventDetailsController eventDetailsController =
      Get.put(EventDetailsController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 93, 58, 153),
        title: Text(
          "Tickets",
          style: GoogleFonts.ptSans(
            fontSize: 27.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Get.off(() => HomeScreen()),
          child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 24.sp),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Icon(Icons.print_outlined, color: Colors.white, size: 26.sp),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            // Ticket Container
            Obx(() {
              final event = eventDetailsController.event.value;
              return Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 93, 58, 153),
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Image Section
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.r),
                        topRight: Radius.circular(15.r),
                      ),
                      child: getLocalEventImage(
                          eventDetailsController.event.value.imageUrl),
                    ),
                    // Ticket Details Section
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.eventName.isNotEmpty
                                ? event.eventName
                                : "Event Name",
                            style: GoogleFonts.roboto(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              detailRow(
                                  "Date",
                                  event.date.isNotEmpty
                                      ? event.date
                                      : "Not Set"),
                              SizedBox(width: 20.w),
                              detailRow("Time",
                                  "10:00 PM"), // Time can be dynamically fetched too if available
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              detailRow(
                                  "Venue",
                                  event.location.isNotEmpty
                                      ? event.location
                                      : "Unknown"),
                              SizedBox(width: 20.w),
                              detailRow("Seat",
                                  "05"), // Seat number can be dynamic if needed
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Barcode Section
                    // Container(
                    //   margin: EdgeInsets.symmetric(horizontal: 20.w),
                    //   padding: EdgeInsets.symmetric(vertical: 10.h),
                    //   decoration: BoxDecoration(
                    //     border: Border(
                    //       top: BorderSide(color: Colors.white.withOpacity(0.5)),
                    //     ),
                    //   ),
                    //   child: const Center(
                    //     child: BarcodeGenerator(data: "TICKET298e8sw8nn9"),
                    //   ),
                    // ),
                  ],
                ),
              );
            }),
            const Spacer(),
            // Download Button
            ElevatedButton.icon(
              onPressed: () {
                Get.snackbar(
                  "Success",
                  "Ticket downloaded successfully",
                  icon: const Icon(Icons.check_circle, color: Colors.green),
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.black87,
                  colorText: Colors.white,
                  duration: const Duration(seconds: 3),
                  margin: EdgeInsets.all(10.w),
                );
                Get.offAll(() => HomeScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 80.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              icon: Icon(Icons.download, color: Colors.white, size: 20.sp),
              label: Text(
                "DOWNLOAD IMAGE",
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

Widget getLocalEventImage(String imagePath) {
  log("Image Path Received: $imagePath"); // Debugging

  if (imagePath.isNotEmpty && File(imagePath).existsSync()) {
    log("Displaying Local Image: $imagePath");
    return Image.file(
      File(imagePath),
      height: 180.h,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        log("Error loading image: $error");
        return Image.asset(
          'assets/images/placeholder.jpg',
          height: 180.h,
          width: double.infinity,
          fit: BoxFit.cover,
        );
      },
    );
  } else {
    log("File does not exist, showing placeholder.");
    return Image.asset(
      'assets/images/placeholder.jpg',
      height: 180.h,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
