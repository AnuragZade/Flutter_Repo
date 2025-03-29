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
                SizedBox(height: 16.h),
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
                          fontSize: 16.sp,
                          color: Colors.deepPurple,
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
      backgroundColor: Colors.transparent, // Transparent to show gradient
      elevation: 0,
      toolbarHeight: 70.h,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.black87],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(right: 16.w, left: 16.w, top: 26.h),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundImage:
                    const AssetImage("assets/images/person_vector_2.png"),
              ),
              SizedBox(width: 12.w),
              Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Hi Welcome 👋",
                        style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('planify_username')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return _loadingText();
                        }
                        if (snapshot.hasError ||
                            !snapshot.hasData ||
                            !snapshot.data!.exists) {
                          return _unknownUserText();
                        }
                        String username = snapshot.data!['name'];
                        return _usernameText(username);
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "    Current location",
                      style: GoogleFonts.roboto(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.red),
                        Obx(
                          () => SizedBox(
                            width: 100.w, // Prevents overflow
                            child: Text(
                              mapController.currentAddress.value,
                              style: GoogleFonts.roboto(
                                fontSize: 12.sp,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Helper functions for better readability and consistency
  Widget _loadingText() => Text(
        "Loading...",
        style: GoogleFonts.poppins(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );

  Widget _unknownUserText() => Text(
        "Unknown User",
        style: GoogleFonts.poppins(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );

  Widget _usernameText(String username) {
    String firstName = username.split(' ')[0];
    return Text(
      firstName,
      style: GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
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
          border: Border.all(color: Colors.grey.withOpacity(0.5)),
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
      closedColor: Colors.transparent,
      closedBuilder: (context, action) => Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.black87],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Card(
          elevation: 6,
          color: Colors.transparent, // Transparent to show the gradient
          shadowColor: Colors.black.withOpacity(0.2),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: "card_event_$index",
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: isFirebaseImage
                      ? Image.network(
                          event.imageUrl,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              height: 160,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "assets/images/event.jpg",
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          },
                        )
                      : Image.asset(
                          "assets/images/event.jpg",
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.eventName,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors
                              .white, // Ensure text contrasts with gradient
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 16, color: Colors.white),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              event.location,
                              style: GoogleFonts.roboto(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 16, color: Colors.white),
                          const SizedBox(width: 4),
                          Text(
                            event.date,
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.8)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      openBuilder: (context, action) => EventDetailsScreen(eventIndex: index),
    );
  }

  Widget _buildPopularEvents() {
    return Obx(() {
      List<Map<String, dynamic>> eventList = firebaseNewEventController.events;
      if (eventList.isEmpty) {
        return const Center(child: Text("No Events Found"));
      }
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 events in one row
          crossAxisSpacing: 12, // Spacing between columns
          mainAxisSpacing: 12, // Spacing between rows
          childAspectRatio: 0.75, // Adjust to maintain card aspect ratio
        ),
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
