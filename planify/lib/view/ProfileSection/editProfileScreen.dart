// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';

// class EditProfileScreen extends StatelessWidget {
//   const EditProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     XFile? image;

//     final TextEditingController nameController = TextEditingController();
//     final TextEditingController dobController = TextEditingController();
//     final TextEditingController locationController = TextEditingController();
//     final TextEditingController interestedEventController =
//         TextEditingController();

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.of(context).pop();
//           },
//           child: const Icon(
//             Icons.arrow_back_ios,
//           ),
//         ),
//         title: Text(
//           "Edit Profile",
//           style: GoogleFonts.karla(
//             fontSize: 28,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Divider(),
//               Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Center(
//                   child: Stack(
//                     children: [
//                       // Circular profile picture
//                       GestureDetector(
//                         onTap: () async {
//                           ImagePicker imagePicker = ImagePicker();
//                           image = await imagePicker.pickImage(
//                               source: ImageSource.gallery);
//                         },
//                         child: const CircleAvatar(
//                           radius: 50, // Adjust size as needed
//                           backgroundColor: Color.fromARGB(255, 93, 58, 153),
//                           child: CircleAvatar(
//                             radius:
//                                 48, // Slightly smaller to create a border effect
//                             backgroundImage: AssetImage(
//                                 'assets/images/AppLogo.png'), // Replace with your image
//                           ),
//                         ),
//                       ),
//                       // Edit icon overlay
//                       Positioned(
//                         bottom: 2,
//                         right: 5,
//                         child: Container(
//                           height: 24,
//                           width: 24,
//                           decoration: const BoxDecoration(
//                             color: Color.fromARGB(255, 93, 58, 153),
//                             shape: BoxShape.circle,
//                           ),
//                           child: const Icon(
//                             Icons.edit,
//                             size: 16,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 "Full Name",
//                 style: GoogleFonts.karla(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 10, bottom: 10),
//                 child: TextField(
//                   controller: nameController,
//                   decoration: InputDecoration(
//                     hintText: "Anurag Zade",
//                     hintStyle: GoogleFonts.poppins(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.grey.withOpacity(0.8),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(
//                         color: Colors.black,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(
//                         color: Color.fromARGB(255, 93, 58, 153),
//                       ),
//                     ),
//                     suffixIcon: GestureDetector(
//                       child: const Icon(
//                         Icons.person,
//                         size: 30,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Text(
//                 "Date of Birth",
//                 style: GoogleFonts.karla(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 10, bottom: 10),
//                 child: TextField(
//                   controller: dobController,
//                   decoration: InputDecoration(
//                     hintText: "29 Oct, 2002",
//                     hintStyle: GoogleFonts.poppins(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.grey.withOpacity(0.8),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(
//                         color: Colors.black,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(
//                         color: Color.fromARGB(255, 93, 58, 153),
//                       ),
//                     ),
//                     suffixIcon: GestureDetector(
//                       onTap: () async {
//                         // Open the date picker
//                         DateTime? selectedDate = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(1980),
//                           lastDate:
//                               DateTime.now(), // Set to the current system date
//                           // barrierColor: Color.fromARGB(255, 93, 58, 153),
//                         );

//                         if (selectedDate != null) {
//                           // Format the selected date and set it in the TextField
//                           dobController.text =
//                               "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
//                         }
//                       },
//                       child: const Icon(
//                         Icons.calendar_month,
//                         color: Color.fromARGB(255, 93, 58, 153),
//                         size: 30,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Text(
//                 "Location",
//                 style: GoogleFonts.karla(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 10, bottom: 10),
//                 child: TextField(
//                   controller: locationController,
//                   decoration: InputDecoration(
//                     hintText: "Vadgoan bk, Pune",
//                     hintStyle: GoogleFonts.poppins(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.grey.withOpacity(0.8),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(
//                         color: Colors.black,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(
//                         color: Color.fromARGB(255, 93, 58, 153),
//                       ),
//                     ),
//                     suffixIcon: GestureDetector(
//                       onTap: () {},
//                       child: const Icon(
//                         Icons.location_on,
//                         color: Colors.green,
//                         size: 30,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Text(
//                 "Intrested Event",
//                 style: GoogleFonts.karla(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 10, bottom: 10),
//                 child: TextField(
//                   controller: interestedEventController,
//                   decoration: InputDecoration(
//                     hintText: "Design, Art, Dance, Music",
//                     hintStyle: GoogleFonts.poppins(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.grey.withOpacity(0.8),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(
//                         color: Colors.black,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(
//                         color: Color.fromARGB(255, 93, 58, 153),
//                       ),
//                     ),
//                     suffixIcon: GestureDetector(
//                       child: const Icon(
//                         Icons.favorite,
//                         color: Colors.red,
//                         size: 30,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 130,
//               ),
//               GestureDetector(
//                 onTap: () {},
//                 child: Center(
//                   child: Container(
//                     height: 50,
//                     width: 350,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       gradient: const LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           Colors.black45,
//                           Colors.black54,
//                           Colors.black87,
//                         ],
//                       ),
//                       boxShadow: const [
//                         BoxShadow(
//                           offset: Offset(0, 7),
//                           blurRadius: 8,
//                           spreadRadius: 1,
//                           color: Colors.grey,
//                         ),
//                       ],
//                     ),
//                     clipBehavior: Clip.antiAlias,
//                     child: Center(
//                       child: Text(
//                         "Save Changes",
//                         style: GoogleFonts.poppins(
//                           fontSize: 25,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
