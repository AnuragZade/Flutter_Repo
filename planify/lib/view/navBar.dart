import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../controller/nav_controller.dart';

class PersistanrnavCustom extends StatelessWidget {
  const PersistanrnavCustom({super.key});

  @override
  Widget build(BuildContext context) {
    final NavController navBarController = Get.put(NavController());

    return GetBuilder<NavController>(
      builder: (controller) {
        return PersistentTabView(
          context,
          controller: controller.persistentController,
          navBarHeight: 70,
          navBarStyle: NavBarStyle.style1,
          screens: controller.screens,
          items: [
            PersistentBottomNavBarItem(
              activeColorPrimary: const Color.fromARGB(255, 93, 58, 153),
              title: ("Home"),
              textStyle: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              icon: const Icon(Icons.home, size: 36),
              inactiveIcon: const Icon(Icons.home_outlined),
            ),
            PersistentBottomNavBarItem(
              activeColorPrimary: const Color.fromARGB(255, 93, 58, 153),
              title: ("Categories"),
              textStyle: GoogleFonts.roboto(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              icon: const Icon(Icons.category, size: 36),
              inactiveIcon: const Icon(Icons.category_outlined),
            ),
            PersistentBottomNavBarItem(
              activeColorPrimary: const Color.fromARGB(255, 93, 58, 153),
              title: ("Events"),
              textStyle: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              icon: const Icon(Icons.bakery_dining, size: 36),
              inactiveIcon: const Icon(Icons.bakery_dining_outlined),
            ),
            PersistentBottomNavBarItem(
              activeColorPrimary: const Color.fromARGB(255, 93, 58, 153),
              title: ("Map"),
              textStyle: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              icon: const Icon(Icons.location_on, size: 36),
              inactiveIcon: const Icon(Icons.location_on_outlined),
            ),
            PersistentBottomNavBarItem(
              activeColorPrimary: const Color.fromARGB(255, 93, 58, 153),
              title: ("Profile"),
              textStyle: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              inactiveIcon: const CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage("assets/images/AppLogo.png"),
              ),
              icon: Container(
                clipBehavior: Clip.antiAlias,
                height: 45,
                width: 45,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: AssetImage("assets/images/AppLogo.png"),
                ),
              ),
            ),
          ],
          onItemSelected: (index) {
            controller.changeIndex(index);
          },
        );
      },
    );
  }
}
