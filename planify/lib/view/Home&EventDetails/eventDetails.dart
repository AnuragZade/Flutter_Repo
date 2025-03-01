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
    ScreenUtil.init(context, designSize: Size(375, 812), minTextAdapt: true);
    final FirebaseController firebaseNewEventController = Get.find();
    final event = firebaseNewEventController.events[widget.eventIndex];

    final List<String> images = [
      event["image"] ?? "",
      "assets/images/event.jpg",
      "assets/images/event.jpg",
      "assets/images/event.jpg",
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child:
              Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 30.sp),
        ),
        title: Text(
          "Event Details",
          style: GoogleFonts.roboto(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 93, 58, 153),
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.r),
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                    height: 230.h,
                                    enlargeCenterPage: true,
                                    viewportFraction: 0.8,
                                    enableInfiniteScroll: true,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 3),
                                    onPageChanged: (index, reason) {
                                      currentIndex.value = index;
                                    },
                                  ),
                                  items: images.map((imageUrl) {
                                    return Builder(
                                      builder: (context) {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          child: _buildEventImage(imageUrl),
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Obx(() => AnimatedSmoothIndicator(
                                  activeIndex: currentIndex.value,
                                  count: 3,
                                  effect: const ExpandingDotsEffect(
                                    dotHeight: 8,
                                    dotWidth: 8,
                                    activeDotColor:
                                        Color.fromARGB(255, 93, 58, 153),
                                    dotColor: Colors.grey,
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      event["title"] ?? "No Title",
                      style: GoogleFonts.poppins(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.red, size: 20.sp),
                        SizedBox(width: 5.w),
                        Row(
                          children: [
                            Text(
                              event["location"] ?? "Unknown",
                              style: GoogleFonts.roboto(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 5.w),


                            ///GET DIRECTION
                            GestureDetector(
                              onTap: () {
                                void openGoogleMaps(String cityName) async {
                                  String googleUrl =
                                      "https://www.google.com/maps/dir/?api=1&destination=$cityName";
                                  if (await canLaunchUrl(
                                      Uri.parse(googleUrl))) {
                                    await launchUrl(Uri.parse(googleUrl));
                                  } else {
                                    throw 'Could not open Google Maps';
                                  }
                                }

                                openGoogleMaps(event["location"] ?? "Unknown");
                              },
                              child: Text(
                                "Get Directions",
                                style: GoogleFonts.roboto(
                                  fontSize: 15.sp,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Icon(Icons.calendar_today,
                            color: Colors.black, size: 20.sp),
                        SizedBox(width: 5.w),
                        Text(
                          event["date"] ?? "Unknown Date",
                          style: GoogleFonts.roboto(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    const Divider(),
                    SizedBox(height: 10.h),
                    Text(
                      'Description:',
                      style: GoogleFonts.roboto(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.h),
                    Obx(() {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event["description"] ?? "No Description",
                            maxLines: isExpanded.value ? null : 3,
                            overflow: isExpanded.value
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(fontSize: 16.sp),
                          ),
                          SizedBox(height: 10.h),
                          GestureDetector(
                            onTap: () {
                              isExpanded.value = !isExpanded.value;
                            },
                            child: Text(
                              isExpanded.value ? 'Read Less' : 'Read More',
                              style: GoogleFonts.roboto(
                                  fontSize: 14.sp, color: Colors.blue),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 50.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Icon(Icons.bookmark_add_outlined, size: 24.sp),
                ),
                GestureDetector(
                  onTap: () {
                    log("Navigate to ticket booking screen");
                  },
                  child: Container(
                    height: 50.h,
                    width: 200.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.black),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => const TicketDetailsScreen());
                        },
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
          ),
        ],
      ),
    );
  }

  Widget _buildEventImage(String imagePath) {
    if (imagePath.isNotEmpty && File(imagePath).existsSync()) {
      return Image.file(File(imagePath),
          fit: BoxFit.cover, width: double.infinity);
    } else {
      return Image.asset("assets/images/event.jpg",
          fit: BoxFit.cover, width: double.infinity);
    }
  }
}
