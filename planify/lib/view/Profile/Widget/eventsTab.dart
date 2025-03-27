import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../controller/firebase_event_controller.dart';

class EventsTab extends StatelessWidget {
  EventsTab({super.key});

  final FirebaseController firebaseNewEventController =
      Get.put(FirebaseController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var eventList = firebaseNewEventController.events;

      if (eventList.isEmpty) {
        return Center(
          child: Text(
            "No Events Found 😞",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
        );
      }

      return ListView.builder(
        itemCount: eventList.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final event = eventList[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.white,
              shadowColor: Colors.deepPurple.withOpacity(0.2),
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  // Action on card tap (navigate or show details)
                },
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildEventImage(event),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event["eventName"] ??
                                  event["title"] ??
                                  "Untitled Event",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            _buildInfoRow(Icons.calendar_today_rounded,
                                event["eventDate"] ?? event["date"] ?? "N/A"),
                            _buildInfoRow(
                                Icons.location_on_rounded,
                                event["eventLocation"] ??
                                    event["location"] ??
                                    "Unknown"),
                            _buildInfoRow(
                                Icons.monetization_on_rounded,
                                _formatPrice(event["eventTicketPrice"] ??
                                    event["price"])),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  /// Function to handle Firestore images
  Widget _buildEventImage(Map<String, dynamic> event) {
    String? imagePath;
    if (event["images"] != null && event["images"].isNotEmpty) {
      imagePath = event["images"][0]; // Fetch first image if available
    } else {
      imagePath = event["imageUrl"] ?? event["image"];
    }

    if (imagePath == null || imagePath.isEmpty) {
      return _defaultEventImage();
    }
    if (imagePath.startsWith("http")) return _networkImage(imagePath);

    return _localImage(imagePath);
  }

  Widget _networkImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(
        imageUrl,
        width: 90,
        height: 90,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stackTrace) {
          debugPrint("Image Load Error: $error");
          return _defaultEventImage();
        },
      ),
    );
  }

  Widget _localImage(String imagePath) {
    bool fileExists = File(imagePath).existsSync();
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: fileExists
          ? Image.file(File(imagePath),
              width: 90, height: 90, fit: BoxFit.cover)
          : _defaultEventImage(),
    );
  }

  Widget _defaultEventImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.asset(
        "assets/images/event_placeholder.jpg",
        width: 90,
        height: 90,
        fit: BoxFit.cover,
      ),
    );
  }

  /// Helper function to format price properly
  String _formatPrice(dynamic price) {
    if (price == null || price.toString().trim().isEmpty) return "Free 🎉";
    return "₹${price.toString()}";
  }

  /// Helper function to create icon-text rows
  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.deepPurple),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              text,
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
