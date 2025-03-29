import 'dart:developer';
import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planify/view/Profile/Widget/aboutTab.dart';
import 'package:planify/view/Profile/Widget/eventsTab.dart';
import '../../controller/edit_profile_controller.dart';
import '../../controller/firebase_event_controller.dart';
import '../../controller/profileController.dart';

class OrganizerProfileAbout extends StatelessWidget {
  OrganizerProfileAbout({super.key});

  final ProfileController profileController = Get.put(ProfileController());

  final FirebaseController firebaseNewEventController =
      Get.put(FirebaseController());

  final EditProfileController editProfileController =
      Get.put(EditProfileController());

  final ImagePicker picker = ImagePicker();

  // Widget _buildTextField(
  //     String label, TextEditingController controller, IconData icon) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8.0),
  //     child: TextField(
  //       controller: controller,
  //       decoration: InputDecoration(
  //         labelText: label,
  //         prefixIcon: Icon(icon),
  //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  //       ),
  //     ),
  //   );
  // }

  void openEditProfileBottomSheet(BuildContext context) {
    final EditProfileController editProfileController =
        Get.find<EditProfileController>();

    Get.bottomSheet(
      Container(
        height: Get.height * 0.5,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: EdgeInsets.all(Get.width * 0.04),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Edit Profile',
                style: GoogleFonts.ptSans(
                  fontSize: Get.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Profile Image Picker
              GestureDetector(
                onTap: () => editProfileController.pickImage(),
                child: Obx(
                  () => CircleAvatar(
                    radius: 50,
                    backgroundImage: editProfileController.profileImage.value !=
                            null
                        ? FileImage(editProfileController.profileImage.value!)
                        : const AssetImage(
                                "assets/images/profile_placeholder.png")
                            as ImageProvider,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Username Field
              TextField(
                controller: editProfileController.usernameController,
                decoration: InputDecoration(
                  labelText: "Edit Username",
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 10),

              // About Field
              TextField(
                controller: editProfileController.aboutController,
                decoration: InputDecoration(
                  labelText: "Edit About",
                  prefixIcon: const Icon(Icons.info),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 10),

              // Save Button
              ElevatedButton(
                onPressed: () {
                  editProfileController.updateProfile();
                  Get.back();
                },
                child: const Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  void openBottomSheetForNewEvent(BuildContext context) {
    Get.bottomSheet(
      WillPopScope(
        onWillPop: () async {
          firebaseNewEventController.selectedImages.clear();
          return true;
        },
        child: Container(
          height: 0.85.sh,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FadeInUp(
                  child: Text(
                    'Add New Event',
                    style: GoogleFonts.ptSans(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                GestureDetector(
                  onTap: () => firebaseNewEventController.pickImages(),
                  child: Obx(
                    () => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      height: 180.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: firebaseNewEventController
                              .selectedImages.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.file(
                                firebaseNewEventController.selectedImages.first,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            )
                          : Center(
                              child: Text(
                                "Tap to add exactly 1 image",
                                style: GoogleFonts.ptSans(fontSize: 16.sp),
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                ..._buildTextFields(),
                SizedBox(height: 15.h),
                BounceInUp(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 14.h, horizontal: 30.w),
                    ),
                    onPressed: () {
                      if (firebaseNewEventController.selectedImages.length !=
                          1) {
                        Get.snackbar("Error", "Please select exactly 1 image");
                        return;
                      }
                      firebaseNewEventController.uploadImage();
                    },
                    child: Text(
                      "Add Event",
                      style: GoogleFonts.ptSans(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    ).whenComplete(() {
      firebaseNewEventController.selectedImages.clear();
    });
  }

  List<Widget> _buildTextFields() {
    return [
      _buildTextField2("Event Category",
          firebaseNewEventController.eventCategoryController, Icons.category),
      _buildTextField2("Organizer Name",
          firebaseNewEventController.organizerNameController, Icons.person),
      _buildTextField2("Event Name",
          firebaseNewEventController.eventNameController, Icons.event),
      _buildTextField2("Event Date",
          firebaseNewEventController.eventDateController, Icons.calendar_today),
      _buildTextField2("Ticket Price",
          firebaseNewEventController.ticketPriceController, Icons.money),
      _buildTextField2(
          "Event Location",
          firebaseNewEventController.eventLocationController,
          Icons.location_on),
      _buildTextField2("Description",
          firebaseNewEventController.descriptionController, Icons.description),
    ];
  }

  Widget _buildTextField2(
      String label, TextEditingController controller, IconData icon) {
    return FadeInLeft(
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon, size: 20.sp),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
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
          title: Text(
            "Profile",
            style: GoogleFonts.karla(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(height: Get.height * 0.04),
            Obx(() => CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      editProfileController.profileImage.value != null
                          ? FileImage(editProfileController.profileImage.value!)
                          : const AssetImage("assets/images/person_vector.png")
                              as ImageProvider,
                )),

            const SizedBox(height: 10),
            // Username (Dynamic)
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
                      color: Colors.black,
                    ),
                  );
                }
                if (snapshot.hasError) {
                  log('Error fetching data: ${snapshot.error}');
                  return Text(
                    "Error loading data",
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  );
                }
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  log('No data found for user ID: ${FirebaseAuth.instance.currentUser!.uid}');
                  return Text(
                    "Unknown User",
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  );
                }

                String username = snapshot.data!['name'];
                log('Fetched username: $username');

                return Text(
                  username,
                  style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                );
              },
            ),

            TextButton(
              onPressed: () => openEditProfileBottomSheet(context),
              child: Text("Edit Profile",
                  style: GoogleFonts.ptSans(
                      fontSize: 18, color: Colors.deepPurple)),
            ),
            const TabBar(
              tabs: [
                Tab(text: "About"),
                Tab(text: "Events"),
                // Tab(text: "Reviews"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AboutTab(),
                  EventsTab(),
                  // ReviewsTab(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: GestureDetector(
          onTap: () => openBottomSheetForNewEvent(context),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.deepPurpleAccent, Colors.black87],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurpleAccent.withOpacity(0.6),
                  blurRadius: 15,
                  spreadRadius: 2,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.add, color: Colors.white, size: 26),
                const SizedBox(width: 8),
                Text(
                  "Add Event",
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
