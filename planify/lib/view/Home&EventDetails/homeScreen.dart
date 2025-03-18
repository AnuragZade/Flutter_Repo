import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:planify/controller/signUpController.dart';
import 'package:planify/controller/topOrganizerController.dart';
import 'package:planify/view/Categories/topOrganizerScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animations/animations.dart';
import '../../controller/firebase_event_controller.dart';
import '../../controller/mapController.dart';
import '../../model/eventCardModel.dart';
import 'eventDetails.dart';
import 'viewAllEvents.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final FirebaseController firebaseNewEventController =
      Get.put(FirebaseController());
  final CategoryController categoryController = Get.put(CategoryController());
  final RxInt currentIndex = 0.obs;
  final SignUpController signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSearchBar(),
                SizedBox(height: 16.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Explore Categories",
                        style: GoogleFonts.roboto(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 120, // Adjust height as needed
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryController.categories.length,
                        itemBuilder: (context, index) {
                          return _buildCategoryItem(
                              categoryController.categories[index]);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                _buildCarouselSlider(),
                SizedBox(height: 32.h),
                Row(
                  children: [
                    Text(
                      "Popular Events ✨",
                      style: GoogleFonts.roboto(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.to(ViewAllEventScreen(),
                            transition: Transition.fadeIn,
                            duration: const Duration(milliseconds: 300));
                      },
                      child: Text(
                        "See all",
                        style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                _buildPopularEvents(),
              ],
            ),
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
      toolbarHeight: 70.h,
      flexibleSpace: Padding(
        padding:
            EdgeInsets.only(left: 16.w, right: 16.w, top: 45.h, bottom: 10.h),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.r,
              backgroundImage:
                  const AssetImage("assets/images/person_vector_2.png"),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hi Welcome 👋",
                    style: GoogleFonts.roboto(
                        fontSize: 14.sp, color: Colors.white)),
                // ✅ Display dynamic username here
                FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('planify_username')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text(
                        "Loading...",
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    }
                    if (snapshot.hasError ||
                        !snapshot.hasData ||
                        !snapshot.data!.exists) {
                      return Text(
                        "Unknown User",
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    }

                    String username = snapshot.data!['name'];
                    return Text(
                      username,
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("       Current location",
                    style: GoogleFonts.roboto(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.red),
                    Obx(() => Text(
                          mapController.currentAddress.value,
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
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 20),
            child: child,
          ),
        );
      },
      child: Container(
        height: 50.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 8.w),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Find amazing events'),
              ),
            ),
            const Icon(Icons.filter_list, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselSlider() {
    return Column(
      children: [
        CarouselSlider(
          items: [
            "assets/images/music/music3.jpg",
            "assets/images/wedding/wedding10.jpg",
            "assets/images/music/music6.jpg",
            "assets/images/tech/tech1.jpg"
          ].map((imagePath) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: AspectRatio(
                aspectRatio: 16 / 9, // ✅ Consistent landscape aspect ratio
                child: Image.asset(
                  imagePath,
                  width: 1.sw,
                  height: 200.h,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 200.h,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.85,
            onPageChanged: (index, reason) {
              currentIndex.value = index;
            },
          ),
        ),
        SizedBox(height: 10.h),
        Obx(() => AnimatedSmoothIndicator(
              activeIndex: currentIndex.value,
              count: 3,
              effect: const ExpandingDotsEffect(
                dotHeight: 6,
                dotWidth: 6,
                activeDotColor: Colors.deepPurple,
              ),
            )),
      ],
    );
  }

  Widget _buildEventCard(NewEventData event, int index) {
    bool isFirebaseImage = event.imageUrl.startsWith("http");

    return OpenContainer(
      closedElevation: 0,
      closedBuilder: (context, action) => Card(
        shadowColor: Colors.grey,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Hero(
                tag: "card_event_$index", // ✅ Unique tag for event cards
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: isFirebaseImage
                      ? Image.network(
                          event.imageUrl,
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                                child: CircularProgressIndicator());
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
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event.eventName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(event.location,
                        style: TextStyle(color: Colors.grey[600])),
                    const SizedBox(height: 4),
                    Text(event.date,
                        style:
                            TextStyle(fontSize: 12, color: Colors.grey[700])),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      openBuilder: (context, action) => EventDetailsScreen(
        eventIndex: index,
      ),
    );
  }

  Widget _buildPopularEvents() {
    return Obx(() {
      List<Map<String, dynamic>> eventList = firebaseNewEventController.events;
      if (eventList.isEmpty) {
        return const Center(child: Text("No Events Found"));
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: eventList.length,
        itemBuilder: (context, index) {
          final event = NewEventData.fromMap(eventList[index]);
          return _buildEventCard(event, index);
        },
      );
    });
  }

  Widget _buildCategoryItem(Map<String, String> category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Get.to(() => TopOrganizerScreen(category: category["name"]!)),
            child: ClipOval(
              child: Image.asset(
                category['image']!,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            category['name']!,
            style: GoogleFonts.roboto(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
