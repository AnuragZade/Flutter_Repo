import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../controller/nav_controller.dart';

class PersistanrnavCustom extends StatelessWidget {
  const PersistanrnavCustom({super.key});

  @override
  Widget build(BuildContext context) {
    final NavController controller = Get.put(NavController());

    return GetBuilder<NavController>(
      builder: (controller) {
        return PersistentTabView(
          context,
          controller: controller.persistentController, // Use the controller
          navBarHeight: 70,
          navBarStyle: NavBarStyle.style1,
          screens: controller.screens,
          items: [
            PersistentBottomNavBarItem(
              icon: const Icon(Icons.home, size: 36),
              inactiveIcon: const Icon(Icons.home_outlined),
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(Icons.event, size: 36),
              inactiveIcon: const Icon(Icons.event_outlined),
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(Icons.home, size: 36),
              inactiveIcon: const Icon(Icons.map),
            ),
            PersistentBottomNavBarItem(
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
