import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/topOrganizerController.dart';
import 'organizerDetailsScreen.dart';

// Organizer Screen
class TopOrganizerScreen extends StatelessWidget {
  final String category;
  const TopOrganizerScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final CategoryController controller = Get.find();
    List<Map<String, dynamic>> organizers =
        controller.organizers[category] ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 93, 58, 153),
        title: Text(
          "Top Organizers - $category",
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 0.8,
          ),
          itemCount: organizers.length,
          itemBuilder: (context, index) {
            final organizer = organizers[index];
            return FadeInUp(
              duration: Duration(milliseconds: 500 + (index * 100)),
              child: Card(
                color: Colors.white,
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: InkWell(
                  onTap: () => Get.to(
                      () => OrganizerDetailsScreen(organizer: organizer)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15.r)),
                          child: Image.asset(
                            organizer["image"]!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        organizer["name"]!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "Reviews: ${organizer["reviews"]!}",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(fontSize: 14.sp),
                        maxLines: 1,
                      ),
                      SizedBox(height: 5.h),
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
