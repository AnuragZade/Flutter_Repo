import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// Organizer Details Screen with Details at the Top and TabBar
class OrganizerDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> organizer;
  OrganizerDetailsScreen({super.key, required this.organizer});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 93, 58, 153),
          title: Text(
            organizer["name"]!,
            style: GoogleFonts.roboto(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 10.h),
            _buildCarouselSlider(organizer),
            SizedBox(height: 10.h),
            const TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              tabs: [
                Tab(text: "About"),
                Tab(text: "Reviews"),
                Tab(text: "Budget"),
                Tab(text: "Gallery"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Text(organizer["about"]!,
                        style: GoogleFonts.roboto(fontSize: 14.sp)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Text("Reviews: ${organizer["reviews"]!}",
                        style: GoogleFonts.roboto(fontSize: 14.sp)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Text("Budget: ${organizer["budget"]!}",
                        style: GoogleFonts.roboto(fontSize: 14.sp)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: organizer["events"].length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.asset(
                            organizer["events"][index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildCarouselSlider(Map<String, dynamic> organizer) {
  final RxInt currentIndex = 0.obs;

  List<dynamic> events =
      organizer["events"] is List ? organizer["events"] : [organizer["events"]];

  return Column(
    children: [
      CarouselSlider(
        items: events.map<Widget>((event) {
          String imageUrl = event is String ? event : event["imageUrl"];

          return Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          );
        }).toList(),
        options: CarouselOptions(
          height: Get.height * 0.25,
          autoPlay: true,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {
            currentIndex.value = index;
          },
        ),
      ),
      SizedBox(height: 10.h),
      Obx(() => AnimatedSmoothIndicator(
            activeIndex: currentIndex.value,
            count: events.length,
            effect: const ExpandingDotsEffect(
              dotHeight: 6,
              dotWidth: 6,
              activeDotColor: Colors.deepPurple,
            ),
          )),
    ],
  );
}
