import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planify/view/OrganizerProfile/Widget/aboutTab.dart';
import 'package:planify/view/OrganizerProfile/Widget/eventsTab.dart';
import 'package:planify/view/OrganizerProfile/Widget/reviewTab.dart';
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

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

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
      Container(
        height: Get.height * 0.8,
        padding: EdgeInsets.all(Get.width * 0.04),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Add New Event',
                  style: GoogleFonts.ptSans(
                      fontSize: Get.width * 0.05, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => firebaseNewEventController.pickImages(),
                child: Obx(() => Container(
                      height: Get.height * 0.2,
                      width: Get.width * 0.8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey)),
                      child: firebaseNewEventController.selectedImages.length ==
                              1
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                firebaseNewEventController.selectedImages.first,
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
                              ),
                            )
                          : Center(child: Text("Tap to add exactly 1 image")),
                    )),
              ),
              const SizedBox(height: 5),
              _buildTextField1(
                  "Event Category",
                  firebaseNewEventController.eventCategoryController,
                  Icons.category),
              _buildTextField1(
                  "Organizer Name",
                  firebaseNewEventController.organizerNameController,
                  Icons.person),
              _buildTextField1("Event Name",
                  firebaseNewEventController.eventNameController, Icons.event),
              _buildTextField(
                  "Event Date",
                  firebaseNewEventController.eventDateController,
                  Icons.calendar_today),
              _buildTextField1(
                  "Ticket Price",
                  firebaseNewEventController.ticketPriceController,
                  Icons.money),
              _buildTextField1(
                  "Event Location",
                  firebaseNewEventController.eventLocationController,
                  Icons.location_on),
              _buildTextField1(
                  "Description",
                  firebaseNewEventController.descriptionController,
                  Icons.description),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (firebaseNewEventController.selectedImages.length != 1) {
                    Get.snackbar("Error", "Please select exactly 1 image");
                    return;
                  }
                  firebaseNewEventController.uploadImage();
                },
                child: const Text("Add Event"),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildTextField1(
      String label, TextEditingController controller, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 93, 58, 153),
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
                Tab(text: "Reviews"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  AboutTab(),
                  EventsTab(),
                  ReviewsTab(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => openBottomSheetForNewEvent(context),
          label: const Icon(Icons.add),
        ),
      ),
    );
  }
}
