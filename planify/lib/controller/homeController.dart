// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../model/eventCardModel.dart';

// class HomeController extends GetxController {
//   /// Hardcoded event list
//   var events = <NewEventData>[
//     NewEventData(
//       eventName: 'International Band Music Concert',
//       location: 'ABC Avenue, Dhaka',
//       date: '12-15 October, 22',
//       imageUrl: "assets/images/event.jpg",
//       organizer: "Anurag Zade",
//       description: "An amazing international band performing live!",
//       members: 15700,
//       price: "4545"
//     ),
//     NewEventData(
//       eventName: 'Band Music Concert',
//       location: 'XYZ Avenue, Pune',
//       date: '15 Nov, 25',
//       imageUrl: "assets/images/event.jpg",
//       organizer: "Ayush",
//       description: "An exciting music concert in Pune!",
//       members: 8500,
//       price: "2000"
//     ),
//   ].obs;

//   /// Filtered event list for search functionality
//   var filteredEvents = <NewEventData>[].obs;

//   @override
//   void onInit() {
//     filteredEvents.assignAll(events); // Initially, all events are shown
//     super.onInit();
//   }

//   void searchEvent(String query) {
//     if (query.isEmpty) {
//       filteredEvents.assignAll(events);
//     } else {
//       filteredEvents.assignAll(
//         events.where((event) => event.eventName.toLowerCase().contains(query.toLowerCase())),
//       );
//     }
//   }
// }
