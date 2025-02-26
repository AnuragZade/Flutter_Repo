import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/firebase_event_controller.dart';
import '../../controller/mapController.dart';
import '../../model/eventCardModel.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseController firebaseNewEventController =
      Get.put(FirebaseController());
  final RxInt currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        // 🔹 Enables full-screen scrolling
        physics: BouncingScrollPhysics(), // 🔹 Smooth scrolling
        child: Padding(
          padding: EdgeInsets.all(Get.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              SizedBox(height: Get.height * 0.02),
              _buildCarouselSlider(),
              SizedBox(height: Get.height * 0.04),
              Text(
                "Popular Events ✨",
                style: GoogleFonts.roboto(
                  fontSize: Get.width * 0.06,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              _buildPopularEvents(), // 🔹 Popular events section remains inside the scrollable view
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final MapController mapController = Get.find<MapController>();

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color.fromARGB(255, 93, 58, 153),
      elevation: 0,
      toolbarHeight: Get.height * 0.1,
      flexibleSpace: Padding(
        padding: EdgeInsets.only(
          left: Get.width * 0.05,
          top: Get.height * 0.06,
          right: Get.width * 0.05,
          bottom: Get.height * 0.02,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: Get.width * 0.08,
              backgroundImage:
                  const AssetImage("assets/images/person_vector_2.png"),
            ),
            SizedBox(width: Get.width * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hi Welcome 👋",
                    style: GoogleFonts.roboto(
                        fontSize: Get.width * 0.04, color: Colors.white)),
                Text("Anurag",
                    style: GoogleFonts.poppins(
                        fontSize: Get.width * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("       Current location",
                    style: GoogleFonts.roboto(
                        fontSize: Get.width * 0.035,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.red),
                    Obx(() => Text(
                          mapController
                              .currentAddress.value, // ✅ Updated Address
                          style: GoogleFonts.roboto(color: Colors.white),
                        )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: Get.height * 0.06,
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey),
          SizedBox(width: Get.width * 0.02),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Find amazing events'),
              onChanged: (query) {
                // You can implement search logic here
              },
            ),
          ),
          Icon(Icons.filter_list, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildCarouselSlider() {
    return Column(
      children: [
        CarouselSlider(
          items: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset("assets/images/event.jpg", fit: BoxFit.cover),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset("assets/images/event.jpg", fit: BoxFit.cover),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset("assets/images/event.jpg", fit: BoxFit.cover),
            ),
          ],
          options: CarouselOptions(
            height: Get.height * 0.25,
            autoPlay: true,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              currentIndex.value = index;
            },
          ),
        ),
        SizedBox(height: 10),
        Obx(() => AnimatedSmoothIndicator(
              activeIndex: currentIndex.value,
              count: 3,
              effect: ExpandingDotsEffect(
                dotHeight: 6,
                dotWidth: 6,
                activeDotColor: Colors.deepPurple,
              ),
            )),
      ],
    );
  }

  Widget _buildPopularEvents() {
    return Obx(() {
      List<Map<String, dynamic>> eventList = firebaseNewEventController.events;

      if (eventList.isEmpty) {
        return Center(child: Text("No Events Found"));
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: eventList.length,
        itemBuilder: (context, index) {
          final eventData = eventList[index];

          final event = NewEventData(
            eventName: eventData["eventName"] ?? eventData["title"] ?? "",
            date: eventData["eventDate"] ?? eventData["date"] ?? "",
            location: eventData["eventLocation"] ?? eventData["location"] ?? "",
            price: eventData["eventTicketPrice"] ?? eventData["price"] ?? "",
            organizer:
                eventData["eventOrganizerName"] ?? eventData["organizer"] ?? "",
            description:
                eventData["eventDescription"] ?? eventData["description"] ?? "",
            imageUrl: (eventData["images"] != null &&
                    eventData["images"].isNotEmpty)
                ? eventData["images"][0] // ✅ Fetch first image URL correctly
                : "https://via.placeholder.com/150",
            members: int.tryParse(eventData["members"]?.toString() ?? "0") ?? 0,
          );

          log("✅ Fetched Image URL: ${event.imageUrl}"); // Debugging

          return GestureDetector(
            onTap: () {
              firebaseNewEventController.navigateToEventDetails(index);
            },
            child: _buildEventCard(event),
          );
        },
      );
    });
  }

  Widget _buildEventCard(NewEventData event) {
    bool isFirebaseImage = event.imageUrl.startsWith("http");

    return Card(
      shadowColor: Colors.grey,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: isFirebaseImage
                  ? Image.network(
                      event.imageUrl,
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset("assets/images/event.jpg",
                            height: 60, width: 60, fit: BoxFit.cover);
                      },
                    )
                  : Image.asset(
                      "assets/images/event.jpg",
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.eventName,
                      style:
                         const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 4),
                  Text(event.location,
                      style: TextStyle(color: Colors.grey[600])),
                  SizedBox(height: 4),
                  Text(event.date,
                      style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
