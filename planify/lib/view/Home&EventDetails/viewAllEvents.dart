import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../controller/firebase_event_controller.dart';
import '../../model/eventCardModel.dart';

class ViewAllEventScreen extends StatelessWidget {
  ViewAllEventScreen({super.key});

  final FirebaseController firebaseNewEventController =
      Get.put(FirebaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 93, 58, 153),
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 30.sp),
        ),
        title: Text(
          "Events",
          style: GoogleFonts.ptSans(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Icon(Icons.search_outlined, color: Colors.white, size: 28.sp),
          ),
        ],
        centerTitle: true,
      ),
      body: Obx(() {
        List<Map<String, dynamic>> eventList = firebaseNewEventController.events;

        if (eventList.isEmpty) {
          return Center(
            child: Text(
              "No Events Found",
              style: GoogleFonts.roboto(fontSize: 18.sp),
            ),
          );
        }

        return ListView.builder(
          itemCount: eventList.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final eventData = eventList[index];
            final event = NewEventData(
              eventName: eventData["eventName"] ?? eventData["title"] ?? "Unknown Event",
              date: eventData["eventDate"] ?? eventData["date"] ?? "Unknown Date",
              location: eventData["eventLocation"] ?? eventData["location"] ?? "Unknown Location",
              price: eventData["eventTicketPrice"] ?? eventData["price"] ?? "Free",
              organizer: eventData["eventOrganizerName"] ?? eventData["organizer"] ?? "Unknown Organizer",
              description: eventData["eventDescription"] ?? eventData["description"] ?? "",
              imageUrl: (eventData["images"] != null && eventData["images"].isNotEmpty)
                  ? eventData["images"][0]
                  : "assets/images/event.jpg",
              members: int.tryParse(eventData["members"]?.toString() ?? "0") ?? 0,
            );

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: GestureDetector(
                onTap: () => firebaseNewEventController.navigateToEventDetails(index),
                child: _buildEventCard(event).animate().fade(duration: 500.ms).slideY(begin: 0.2, end: 0),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildEventCard(NewEventData event) {
    bool isLocalFile = event.imageUrl.isNotEmpty && !event.imageUrl.startsWith("http");
    bool isFileExists = isLocalFile ? File(event.imageUrl).existsSync() : false;

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: 170.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5.h),
            blurRadius: 10.r,
            spreadRadius: 2.r,
            color: Colors.grey.withOpacity(0.5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Hero(
                tag: event.eventName,
                child: Container(
                  height: 60.w,
                  width: 60.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1.w),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: isFileExists
                      ? Image.file(File(event.imageUrl), fit: BoxFit.cover)
                      : Image.network(
                          event.imageUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(child: CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset("assets/images/event.jpg", fit: BoxFit.cover);
                          },
                        ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      event.eventName,
                      style: GoogleFonts.roboto(fontSize: 18.sp, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5.h),
                    Text("Date: ${event.date}",
                        style: GoogleFonts.roboto(fontSize: 15.sp, fontWeight: FontWeight.w500)),
                    SizedBox(height: 5.h),
                    Text("Location: ${event.location}",
                        style: GoogleFonts.roboto(fontSize: 15.sp, fontWeight: FontWeight.w500)),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Text("Price: ₹ ${event.price}/-",
                            style: GoogleFonts.roboto(
                                fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.green)),
                        const Spacer(),
                        Text("JOIN NOW",
                            style: GoogleFonts.roboto(
                                fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.deepPurple)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().scale();
  }
}
