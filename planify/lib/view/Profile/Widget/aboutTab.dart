import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planify/controller/edit_profile_controller.dart';

class AboutTab extends StatelessWidget {
  AboutTab({super.key});

  final EditProfileController editProfileController =
      Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event Organizer Title
          Row(
            children: [
              const Icon(Icons.event_available_rounded,
                  color: Colors.deepPurple, size: 28),
              const SizedBox(width: 8),
              Text(
                "About Event Planning 🎉",
                style: GoogleFonts.roboto(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Description Box
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                "Event planning involves multiple steps like budgeting, scheduling, site selection 🏢, coordinating vendors 🎭, security 👮‍♂️, catering 🍽️, and more. Each event is unique, requiring tailored execution and management! 🏆",
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Editable About Section
          GestureDetector(
            onTap: () {
              _showEditDialog(context);
            },
            child: Obx(
              () => Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(Icons.edit,
                          color: Colors.deepPurple), // Edit Icon
                      SizedBox(width: 15.w),
                      Expanded(
                        child: Text(
                          "Edit About ${editProfileController.about.value}",
                          maxLines: 8,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            fontSize: MediaQuery.of(context).size.width > 600
                                ? 18
                                : 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to Show Edit Dialog
  void _showEditDialog(BuildContext context) {
    TextEditingController aboutController =
        TextEditingController(text: editProfileController.about.value);

    Get.defaultDialog(
      title: "Edit About",
      titleStyle: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
      content: Column(
        children: [
          TextField(
            controller: aboutController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: "Edit your about section...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              editProfileController.about.value = aboutController.text;
              Get.back(); // Close the dialog
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: Text("Save", style: GoogleFonts.roboto(fontSize: 16)),
          ),
        ],
      ),
      radius: 10,
    );
  }
}
