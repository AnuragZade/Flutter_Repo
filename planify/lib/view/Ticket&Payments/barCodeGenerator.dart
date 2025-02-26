// // Barcode Generator Widget
// import 'package:barcode/barcode.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class BarcodeGenerator extends StatelessWidget {
//   final String data;
//   const BarcodeGenerator({super.key, required this.data});

//   @override
//   Widget build(BuildContext context) {
//     final Barcode bc = Barcode.code128(); // Generates a Code 128 barcode
//     final svg = bc.toSvg(data, width: 200, height: 80);

//     return Container(
//       // ignore: prefer_const_constructors
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: SvgPicture.string(
//         svg,
//         width: 200,
//         height: 80,
//       ),
//     );
//   }
// }
