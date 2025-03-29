import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planify/view/Ticket&Payments/ticketDetails.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/firebase_event_controller.dart';

class EventDetailsScreen extends StatefulWidget {
  EventDetailsScreen({super.key, required this.eventIndex});

  final int eventIndex;

  @override
  State createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final RxInt currentIndex = 0.obs;
  final RxBool isExpanded = false.obs; // Controls Read More state

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: const Size(375, 812), minTextAdapt: true);
    final FirebaseController firebaseNewEventController = Get.find();
    final event = firebaseNewEventController.events[widget.eventIndex];

    final List<String> images = (event["images"] as List<dynamic>?)
            ?.map((img) => img.toString())
            .toList() ??
        ["assets/images/event.jpg"];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurpleAccent, Colors.black87],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: Builder(
          builder: (context) => GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios_new,
                color: Colors.white, size: 30.sp),
          ),
        ),
        title: Text(
          "Event Details",
          style: GoogleFonts.roboto(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 10.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r)),
                              child: SizedBox(
                                height: 220.h,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.r),
                                  child: _buildEventImage(
                                    images.isNotEmpty
                                        ? images[0]
                                        : 'default_image_url',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event["title"] ?? "No Title",
                          style: GoogleFonts.roboto(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            letterSpacing: 1.1,
                            height: 1.3,
                            shadows: [
                              Shadow(
                                color: Colors.grey.withOpacity(
                                    0.4), // Subtle shadow for depth
                                blurRadius: 2,
                                offset: const Offset(1, 2),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.start,
                        ),

                        SizedBox(height: 10.h),

                        /// Location Row
                        Row(
                          children: [
                            Icon(Icons.location_on,
                                color: Colors.red, size: 22.sp),
                            SizedBox(width: 6.w),
                            Expanded(
                              child: Text(
                                event["location"] ?? "Unknown Location",
                                style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                String googleUrl =
                                    "https://www.google.com/maps/dir/?api=1&destination=${event["location"]}";
                                if (await canLaunchUrl(Uri.parse(googleUrl))) {
                                  await launchUrl(Uri.parse(googleUrl));
                                } else {
                                  throw 'Could not open Google Maps';
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: Colors.blueAccent.withOpacity(0.2),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.directions,
                                        color: Colors.blue, size: 18.sp),
                                    SizedBox(width: 4.w),
                                    Text(
                                      "Get Directions",
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.sp,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        Divider(
                            thickness: 1,
                            height: 20.h,
                            color: Colors.grey[300]),

                        /// Date Row
                        Row(
                          children: [
                            Icon(Icons.calendar_today,
                                color: Colors.black54, size: 20.sp),
                            SizedBox(width: 6.w),
                            Text(
                              event["date"] ?? "Unknown Date",
                              style: GoogleFonts.roboto(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),

                        Divider(
                            thickness: 1,
                            height: 20.h,
                            color: Colors.grey[300]),

                        /// Emojis or Extra Info (Optional)
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.orange, size: 20.sp),
                            SizedBox(width: 6.w),
                            Text(
                              "Exclusive Event! 🌟",
                              style: GoogleFonts.roboto(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.orange[800],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    const Divider(),
                    SizedBox(height: 10.h),
                    Obx(() {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Title with an Icon
                          Row(
                            children: [
                              Icon(Icons.description_rounded,
                                  color: Colors.deepPurple, size: 22.sp),
                              SizedBox(width: 6.w),
                              Text(
                                'Description',
                                style: GoogleFonts.roboto(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                  letterSpacing: 1.1,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 10.h),

                          /// Description Text with Expand/Collapse

                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: Colors.grey[100], // Subtle background
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event["description"] ??
                                      "No Description Available",
                                  maxLines: isExpanded.value ? null : 3,
                                  overflow: isExpanded.value
                                      ? TextOverflow.visible
                                      : TextOverflow.ellipsis,
                                  style: GoogleFonts.raleway(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                    height: 1.5, // Better readability
                                  ),
                                ),

                                SizedBox(height: 10.h),

                                /// Read More / Read Less Button
                                GestureDetector(
                                  onTap: () {
                                    isExpanded.value = !isExpanded.value;
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        isExpanded.value
                                            ? 'Read Less'
                                            : 'Read More',
                                        style: GoogleFonts.raleway(
                                          fontSize: 15.sp,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      Icon(
                                        isExpanded.value
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        color: Colors.blue,
                                        size: 18.sp,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
            child: GestureDetector(
              onTap: () {
                Get.to(() => const TicketDetailsScreen());
              },
              child: Container(
                height: 50.h,
                width: 200.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: const LinearGradient(
                    colors: [Colors.deepPurpleAccent, Colors.black87],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text(
                    "BUY A TICKET",
                    style: GoogleFonts.ptSans(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventImage(String imagePath) {
    if (imagePath.startsWith("http")) {
      return Image.network(imagePath,
          fit: BoxFit.cover, width: double.infinity);
    } else if (imagePath.isNotEmpty && File(imagePath).existsSync()) {
      return Image.file(File(imagePath),
          fit: BoxFit.cover, width: double.infinity);
    } else {
      return Image.asset("assets/images/event.jpg",
          fit: BoxFit.cover, width: double.infinity);
    }
  }
}
