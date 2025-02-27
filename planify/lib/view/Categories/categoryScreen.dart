import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// Controller for managing categories and organizers
class CategoryController extends GetxController {
  final List<Map<String, String>> categories = [
    {"name": "Wedding", "image": "assets/images/event.jpg"},
    {"name": "Music", "image": "assets/images/event.jpg"},
    {"name": "Corporate", "image": "assets/images/event.jpg"},
    {"name": "Sports", "image": "assets/images/event.jpg"},
    {"name": "Tech", "image": "assets/images/event.jpg"},
    {"name": "Fashion", "image": "assets/images/event.jpg"}
  ];

  final Map<String, List<Map<String, dynamic>>> organizers = {
    "Wedding": [
      {
        "name": "Dream Weddings",
        "image": "assets/images/event.jpg",
        "contact": "+1234567890",
        "reviews": "4.8 (120 reviews)",
        "experience": "10 years",
        "budget": "\$5000 - \$20000",
        "about": "We create unforgettable wedding experiences.",
        "events": [
          "assets/images/event.jpg",
          "assets/images/event.jpg",
          "assets/images/event.jpg"
        ],
      },
      {
        "name": "Luxury Events",
        "image": "assets/images/event.jpg",
        "contact": "+0987654321",
        "reviews": "4.7 (98 reviews)",
        "budget": "\$5000 - \$20000",
        "experience": "10 years",
        "about": "We create unforgettable wedding experiences.",
        "events": [
          "assets/images/event.jpg",
          "assets/images/event.jpg",
          "assets/images/event.jpg"
        ],
      },
      {
        "name": "Bridal Bliss",
        "image": "assets/images/event.jpg",
        "contact": "+1122334455",
        "budget": "\$5000 - \$20000",
        "reviews": "4.9 (150 reviews)",
        "experience": "10 years",
        "about": "We create unforgettable wedding experiences.",
        "events": [
          "assets/images/event.jpg",
          "assets/images/event.jpg",
          "assets/images/event.jpg"
        ],
      }
    ],
    "Music": [
      {
        "name": "Rock Nation",
        "image": "assets/images/event.jpg",
        "contact": "+1112233445",
        "reviews": "4.6 (200 reviews)",
        "experience": "10 years",
        "budget": "\$5000 - \$20000",
        "about": "We create unforgettable wedding experiences.",
        "events": [
          "assets/images/event.jpg",
          "assets/images/event.jpg",
          "assets/images/event.jpg"
        ],
      },
      {
        "name": "Jazz Beats",
        "image": "assets/images/event.jpg",
        "contact": "+1223344556",
        "reviews": "4.5 (170 reviews)",
        "experience": "10 years",
        "budget": "\$5000 - \$20000",
        "about": "We create unforgettable wedding experiences.",
        "events": [
          "assets/images/event.jpg",
          "assets/images/event.jpg",
          "assets/images/event.jpg"
        ],
      },
      {
        "name": "EDM Vibes",
        "image": "assets/images/event.jpg",
        "contact": "+1334455667",
        "budget": "\$5000 - \$20000",
        "experience": "10 years",
        "about": "We create unforgettable wedding experiences.",
        "reviews": "4.8 (190 reviews)",
        "events": [
          "assets/images/event.jpg",
          "assets/images/event.jpg",
          "assets/images/event.jpg"
        ],
      }
    ],
    "Corporate": [
      {
        "name": "Elite Conferences",
        "budget": "\$5000 - \$20000",
        "image": "assets/images/event.jpg",
        "contact": "+1445566778",
        "reviews": "4.9 (220 reviews)",
        "experience": "10 years",
        "about": "We create unforgettable wedding experiences.",
        "events": [
          "assets/images/event.jpg",
          "assets/images/event.jpg",
          "assets/images/event.jpg"
        ],
      },
      {
        "name": "BizMeet Solutions",
        "budget": "\$5000 - \$20000",
        "image": "assets/images/event.jpg",
        "contact": "+1556677889",
        "experience": "10 years",
        "about": "We create unforgettable wedding experiences.",
        "reviews": "4.7 (180 reviews)",
        "events": [
          "assets/images/event.jpg",
          "assets/images/event.jpg",
          "assets/images/event.jpg"
        ],
      }
    ],
    "Sports": [
      {
        "name": "Pro Sports Management",
        "budget": "\$5000 - \$20000",
        "image": "assets/images/event.jpg",
        "contact": "+1667788990",
        "experience": "10 years",
        "about": "We create unforgettable wedding experiences.",
        "reviews": "4.8 (250 reviews)",
        "events": [
          "assets/images/event.jpg",
          "assets/images/event.jpg",
          "assets/images/event.jpg"
        ],
      },
      {
        "name": "Athletic Events Co.",
        "image": "assets/images/event.jpg",
        "contact": "+1778899001",
        "budget": "\$5000 - \$20000",
        "reviews": "4.6 (210 reviews)",
        "experience": "10 years",
        "about": "We create unforgettable wedding experiences.",
        "events": [
          "assets/images/event.jpg",
          "assets/images/event.jpg",
          "assets/images/event.jpg"
        ],
      }
    ],
    "Tech": [
      {
        "name": "Innovate Tech Conferences",
        "image": "assets/images/event.jpg",
        "budget": "\$5000 - \$20000",
        "contact": "+1889900112",
        "reviews": "4.9 (300 reviews)",
        "experience": "10 years",
        "about": "We create unforgettable wedding experiences.",
        "events": [
          "assets/images/event.jpg",
          "assets/images/event.jpg",
          "assets/images/event.jpg"
        ],
      },
      {
        "name": "Futurist Events",
        "image": "assets/images/event.jpg",
        "budget": "\$5000 - \$20000",
        "contact": "+1990011223",
        "reviews": "4.7 (270 reviews)",
        "experience": "10 years",
        "about": "We create unforgettable wedding experiences.",
        "events": [
          "assets/images/event.jpg",
          "assets/images/event.jpg",
          "assets/images/event.jpg"
        ],
      }
    ],
    "Fashion": [
      {
        "name": "Glamour Runway",
        "budget": "\$5000 - \$20000",
        "image": "assets/images/event.jpg",
        "contact": "+2001122334",
        "experience": "10 years",
        "about": "We create unforgettable wedding experiences.",
        "reviews": "4.8 (320 reviews)",
        "events": [
          "assets/images/event.jpg",
          "assets/images/event.jpg",
          "assets/images/event.jpg"
        ],
      },
      {
        "name": "Trendsetters Agency",
        "image": "assets/images/event.jpg",
        "budget": "\$5000 - \$20000",
        "contact": "+2112233445",
        "experience": "10 years",
        "about": "We create unforgettable wedding experiences.",
        "reviews": "4.6 (290 reviews)",
        "events": [
          "assets/images/event.jpg",
          "assets/images/event.jpg",
          "assets/images/event.jpg"
        ],
      }
    ]
  };
}

// Category Screen
class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryController controller = Get.put(CategoryController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Categories"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
            childAspectRatio: 0.8,
          ),
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
            final category = controller.categories[index];
            return GestureDetector(
              onTap: () =>
                  Get.to(() => OrganizerScreen(category: category["name"]!)),
              child: FadeInUp(
                duration: Duration(milliseconds: 500 + (index * 100)),
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15.r)),
                          child: Image.asset(
                            category["image"]!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Text(
                          category["name"]!,
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

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
          title: Text(organizer["name"]!),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              margin: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    spreadRadius: 3,
                    offset: Offset(0, 3),
                  )
                ],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Contact: ${organizer["contact"]!}",
                      style: GoogleFonts.roboto(
                          fontSize: 18.sp, fontWeight: FontWeight.w600)),
                  SizedBox(height: 8.h),
                  Text("Experience: ${organizer["experience"]!}",
                      style: GoogleFonts.roboto(
                          fontSize: 18.sp, fontWeight: FontWeight.w600)),
                  SizedBox(height: 8.h),
                  Text("Reviews: ${organizer["reviews"]!}",
                      style: GoogleFonts.roboto(
                          fontSize: 18.sp, fontWeight: FontWeight.w600)),
                  SizedBox(height: 8.h),
                  Text("Budget: ${organizer["budget"]!}",
                      style: GoogleFonts.roboto(
                          fontSize: 18.sp, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            TabBar(
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

// Organizer Screen
class OrganizerScreen extends StatelessWidget {
  final String category;
  OrganizerScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final CategoryController controller = Get.find();
    List<Map<String, dynamic>> organizers =
        controller.organizers[category] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text("Top Organizers - $category")),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: ListView.builder(
          itemCount: organizers.length,
          itemBuilder: (context, index) {
            final organizer = organizers[index];
            return FadeInLeft(
              duration: Duration(milliseconds: 500 + (index * 100)),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(12.w),
                  leading: CircleAvatar(
                    radius: 30.r,
                    backgroundImage: AssetImage(organizer["image"]!),
                  ),
                  title: Text(
                    organizer["name"]!,
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Contact: ${organizer["contact"]!}",
                          style: TextStyle(fontSize: 14.sp)),
                      Text("Reviews: ${organizer["reviews"]!}",
                          style: TextStyle(fontSize: 14.sp)),
                    ],
                  ),
                  onTap: () => Get.to(
                      () => OrganizerDetailsScreen(organizer: organizer)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
