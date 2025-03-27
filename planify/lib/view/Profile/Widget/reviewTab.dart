// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ReviewsTabController extends GetxController {
//   var reviews = List.generate(10, (index) => {
//     "name": "Vivek Nivane",
//     "date": "17 Jan 2025",
//     "rating": 5,
//     "review": "This is a long text example to demonstrate how you can limit the number of lines in a Text widget in Flutter. You can also handle overflow gracefully."
//   }).obs;
// }

// class ReviewsTab extends StatelessWidget {
//   final ReviewsTabController controller = Get.put(ReviewsTabController());

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => ListView.builder(
//         itemCount: controller.reviews.length,
//         physics: const BouncingScrollPhysics(),
//         itemBuilder: (context, index) {
//           var review = controller.reviews[index];
//           return Padding(
//             padding: const EdgeInsets.all(10),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 color: Colors.white,
//                 boxShadow: const [
//                   BoxShadow(
//                     offset: Offset(0, 7),
//                     blurRadius: 8,
//                     spreadRadius: 1,
//                     color: Colors.grey,
//                   ),
//                 ],
//               ),
//               child: ListTile(
//                 leading: CircleAvatar(
//                   backgroundImage: const AssetImage("assets/images/AppLogo.png"),
//                   radius: 30,
//                 ),
//                 title: Text(
//                   review["name"] as String,  // Explicitly cast as String
//                   style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: Text(
//                   review["review"] as String,  // Explicitly cast as String
//                   maxLines: 3,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 trailing: Text(
//                   review["date"] as String,  // Explicitly cast as String
//                   style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
