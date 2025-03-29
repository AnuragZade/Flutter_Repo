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

  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 24.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Events",
          style: GoogleFonts.roboto(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            child: TextField(
              controller: searchController,
              onChanged: (value) => searchQuery.value = value.toLowerCase(),
              decoration: InputDecoration(
                hintText: "Search events...",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1.5), // Added border
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1.5), // Border when not focused
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                      color: Colors.deepPurple.withOpacity(0.5),
                      width: 2.0), // Border when focused
                ),
              ),
            ),
          ),
          // Event List with Filtering
          Expanded(
            child: Obx(() {
              String query = searchQuery.value
                  .trim()
                  .toLowerCase(); // Normalize search query
              List<Map<String, dynamic>> eventList =
                  firebaseNewEventController.events;

              List<Map<String, dynamic>> filteredEvents =
                  eventList.where((event) {
                String eventName = (event["eventName"] ?? event["title"] ?? "")
                    .toString()
                    .toLowerCase();
                String location =
                    (event["eventLocation"] ?? event["location"] ?? "")
                        .toString()
                        .toLowerCase();
                String organizer =
                    (event["eventOrganizerName"] ?? event["organizer"] ?? "")
                        .toString()
                        .toLowerCase();

                return eventName.contains(query) ||
                    location.contains(query) ||
                    organizer.contains(query);
              }).toList();

              if (filteredEvents.isEmpty) {
                return Center(
                  child: Text(
                    "No Events Found",
                    style: GoogleFonts.roboto(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: filteredEvents.length,
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final eventData = filteredEvents[index];
                  final event = NewEventData(
                    eventName: eventData["eventName"] ??
                        eventData["title"] ??
                        "Unknown Event",
                    date: eventData["eventDate"] ??
                        eventData["date"] ??
                        "Unknown Date",
                    location: eventData["eventLocation"] ??
                        eventData["location"] ??
                        "Unknown Location",
                    price: eventData["eventTicketPrice"] ??
                        eventData["price"] ??
                        "Free",
                    organizer: eventData["eventOrganizerName"] ??
                        eventData["organizer"] ??
                        "Unknown Organizer",
                    description: eventData["eventDescription"] ??
                        eventData["description"] ??
                        "",
                    imageUrl: (eventData["images"] != null &&
                            eventData["images"].isNotEmpty)
                        ? eventData["images"][0]
                        : "assets/images/event.jpg",
                    members:
                        int.tryParse(eventData["members"]?.toString() ?? "0") ??
                            0,
                  );

                  return GestureDetector(
                    onTap: () => firebaseNewEventController
                        .navigateToEventDetails(index),
                    child: _buildEventCard(event)
                        .animate()
                        .fade(duration: 400.ms)
                        .slideY(begin: 0.1, end: 0),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(NewEventData event) {
    bool isLocalFile =
        event.imageUrl.isNotEmpty && !event.imageUrl.startsWith("http");
    bool isFileExists = isLocalFile ? File(event.imageUrl).existsSync() : false;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5.h),
            blurRadius: 10.r,
            spreadRadius: 2.r,
            color: Colors.grey.withOpacity(0.3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r),
            ),
            child: isFileExists
                ? Image.file(File(event.imageUrl),
                    width: double.infinity, height: 160.h, fit: BoxFit.cover)
                : Image.network(
                    event.imageUrl,
                    width: double.infinity,
                    height: 160.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset("assets/images/event.jpg",
                          width: double.infinity,
                          height: 160.h,
                          fit: BoxFit.cover);
                    },
                  ),
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(event.eventName,
                        style: GoogleFonts.roboto(
                            fontSize: 18.sp, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Text("${event.location}📍",
                        style: GoogleFonts.roboto(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700])),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Text("📅 ${event.date}",
                        style: GoogleFonts.roboto(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700])),
                    const Spacer(),
                    Text("💰 ₹${event.price}/-",
                        style: GoogleFonts.roboto(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                  ],
                ),
                SizedBox(height: 10.h),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.deepPurpleAccent, Colors.black87],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(
                            8.r), // Ensure rounded corners
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .transparent, // Transparent to show gradient
                          shadowColor:
                              Colors.transparent, // Remove default shadow
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "View Details",
                          style: GoogleFonts.roboto(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
