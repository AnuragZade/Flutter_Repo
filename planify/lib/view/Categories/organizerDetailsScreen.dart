import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OrganizerDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> organizer;
  const OrganizerDetailsScreen({super.key, required this.organizer});

  @override
  State<OrganizerDetailsScreen> createState() => _OrganizerDetailsScreenState();
}

class _OrganizerDetailsScreenState extends State<OrganizerDetailsScreen> {
  final RxInt currentIndex = 0.obs;
  bool isExpanded = false;
  double userRating = 0.0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF5D3A99),
          title: Text(
            widget.organizer["name"]!,
            style: GoogleFonts.roboto(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 2,
        ),
        body: Column(
          children: [
            SizedBox(height: 10.h),
            _buildCarouselSlider(widget.organizer),
            SizedBox(height: 10.h),

            /// ✅ TabBar
            const TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.deepPurple,
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
                  _buildAboutSection(widget.organizer),
                  _buildReviewsSection(widget.organizer),
                  _buildBudgetSection(widget.organizer),
                  _buildGallerySection(widget.organizer),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔥 1. **Interactive About Section**
  Widget _buildAboutSection(Map<String, dynamic> organizer) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedCrossFade(
            firstChild: Text(
              organizer["about"]!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(fontSize: 14.sp, height: 1.5),
            ),
            secondChild: Text(
              organizer["about"]!,
              style: GoogleFonts.roboto(fontSize: 14.sp, height: 1.5),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Row(
                children: [
                  Text(
                    isExpanded ? "Show Less" : "Read More",
                    style: GoogleFonts.roboto(
                      fontSize: 14.sp,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.deepPurple,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// ✅ State variable for reviews
  final RxList<Map<String, dynamic>> _reviews = <Map<String, dynamic>>[].obs;

  /// ✅ 2. **Interactive Reviews Section**
  Widget _buildReviewsSection(Map<String, dynamic> organizer) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ⭐ Title
          Text(
            "Customer Reviews",
            style: GoogleFonts.roboto(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          SizedBox(height: 8.h),

          // 🌟 Overall Rating
          Row(
            children: [
              RatingBarIndicator(
                rating: _calculateAverageRating(),
                itemCount: 5,
                itemSize: 20.sp,
                direction: Axis.horizontal,
                itemBuilder: (context, _) =>
                    const Icon(Icons.star, color: Colors.amber),
              ),
              SizedBox(width: 8.w),
              Text(
                "${_calculateAverageRating().toStringAsFixed(1)}/5",
                style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          // 📝 Individual Reviews
          Expanded(
            child: Obx(() => _reviews.isEmpty
                ? Center(
                    child: Text(
                      "No reviews yet. Be the first to review!",
                      style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        color: Colors.grey[500],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _reviews.length,
                    itemBuilder: (context, index) {
                      final review = _reviews[index];
                      return Card(
                        color: Colors.white,
                        elevation: 3,
                        shadowColor: Colors.grey.withOpacity(0.4),
                        margin: EdgeInsets.only(bottom: 10.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RatingBarIndicator(
                                rating: review['rating'],
                                itemCount: 5,
                                itemSize: 16.sp,
                                direction: Axis.horizontal,
                                itemBuilder: (context, _) =>
                                    const Icon(Icons.star, color: Colors.amber),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                review['review'],
                                style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
          ),
          SizedBox(height: 10.h),

          // ➕ Add Review Button
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                _showAddReviewDialog(context);
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: Text(
                "Add Review",
                style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                shadowColor: Colors.deepPurple.withOpacity(0.4),
                elevation: 5,
                minimumSize:
                    Size(150.w, 45.h), // ✅ Set minimum width and height
              ),
            ),
          )
        ],
      ),
    );
  }

  /// ✅ 3. **Add Review Dialog**
  void _showAddReviewDialog(BuildContext context) {
    double userRating = 0.0;
    final TextEditingController reviewController = TextEditingController();

    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          "Add Review",
          style: GoogleFonts.roboto(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ⭐ Rating Bar
            RatingBar.builder(
              initialRating: userRating,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 30.sp,
              unratedColor: Colors.grey[300],
              itemBuilder: (context, _) =>
                  const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                userRating = rating;
              },
            ),
            SizedBox(height: 10.h),

            // 📝 Review Text Field
            TextFormField(
              controller: reviewController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Write a review...",
                hintStyle: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  color: Colors.grey[500],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide:
                      BorderSide(color: Colors.deepPurple.withOpacity(0.4)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.deepPurple),
                ),
              ),
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
        actions: [
          // ❌ Cancel Button
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              "Cancel",
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                color: Colors.grey[700],
              ),
            ),
          ),

          // ✅ Submit Button
          ElevatedButton(
            onPressed: () {
              if (reviewController.text.isNotEmpty) {
                _addReview(userRating, reviewController.text);
                Get.back(); // Close dialog
              } else {
                Get.snackbar(
                  "Error",
                  "Please enter a review",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              shadowColor: Colors.deepPurple.withOpacity(0.4),
              elevation: 4,
            ),
            child: Text(
              "Submit",
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ 4. **Add New Review to List**
  void _addReview(double rating, String review) {
    _reviews.add({
      'rating': rating,
      'review': review,
    });

    // ✅ Show Success Message
    Get.snackbar(
      "Success",
      "Your review has been added!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      messageText: Text(
        "Your review has been added!",
        style: GoogleFonts.roboto(
          fontSize: 14.sp,
          color: Colors.white,
        ),
      ),
    );
  }

  /// ✅ 5. **Calculate Average Rating**
  double _calculateAverageRating() {
    if (_reviews.isEmpty) return 0.0;
    double total = _reviews.fold(0.0, (sum, review) => sum + review['rating']);
    return total / _reviews.length;
  }

  Widget _buildBudgetSection(Map<String, dynamic> organizer) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.roboto(
            fontSize: 14.sp,
            color: Colors.black87,
          ),
          children: [
            const TextSpan(
              text: "💰 Budget:\n",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: organizer["budget"]
                  .toString(), // ✅ Convert to string explicitly
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ 4. **Interactive Gallery Section**
  Widget _buildGallerySection(Map<String, dynamic> organizer) {
    List<dynamic> events = organizer["events"] ?? [];

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // ✅ 2 columns
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          childAspectRatio: 1.2,
        ),
        itemCount: events.length,
        itemBuilder: (context, index) {
          String imageUrl = events[index];

          return GestureDetector(
            onTap: () => _showFullScreenImage(context, imageUrl),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  void _showFullScreenImage(BuildContext context, String imageUrl) {
    Get.dialog(
      Center(
        child: InteractiveViewer(
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildCarouselSlider(Map<String, dynamic> organizer) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: organizer["events"].length,
          itemBuilder: (context, index, realIndex) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                organizer["events"][index],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          },
          options: CarouselOptions(
            height: 200.h,
            autoPlay: true,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              currentIndex.value = index;
            },
          ),
        ),
        SizedBox(height: 10.h),

        /// ✅ Page Indicator
        Obx(
          () => AnimatedSmoothIndicator(
            activeIndex: currentIndex.value,
            count: organizer["events"].length,
            effect: WormEffect(
              dotHeight: 8.h,
              dotWidth: 8.w,
              activeDotColor: Colors.deepPurple,
              dotColor: Colors.grey.shade400,
            ),
          ),
        ),
      ],
    );
  }
}
