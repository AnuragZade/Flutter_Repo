import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:planify/controller/mapController.dart';
import 'package:planify/view/Categories/categoryScreen.dart';
import 'package:planify/view/Home&EventDetails/viewAllEvents.dart';
import '../mapScreen.dart';
import '../view/Home&EventDetails/homeScreen.dart';
import '../view/OrganizerProfile/profile_About.dart';

class NavController extends GetxController {
  late PersistentTabController persistentController;

  final MapController mapController = Get.put(MapController());
  final List<Widget> screens = [
    HomeScreen(),
    const CategoryScreen(),
    ViewAllEventScreen(),
    MapScreen(eventLocation: ""),
    OrganizerProfileAbout(),
  ];

  @override
  void onInit() {
    super.onInit();
    persistentController = PersistentTabController(initialIndex: 0);
  }

  void changeIndex(int index) {
    persistentController.index = index;
    update();
  }
}
