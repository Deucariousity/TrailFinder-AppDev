// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
//
// import 'College1.dart';
// import 'College2.dart';
// import 'College3.dart';
// import 'College4.dart';
// import 'College5.dart';
//
// class CampusMapScreen extends StatefulWidget {
//   @override
//   _CampusMapScreenState createState() => _CampusMapScreenState();
// }
//
// class _CampusMapScreenState extends State<CampusMapScreen> {
//   final PhotoViewController _photoViewController = PhotoViewController();
//
//   void _onCollegeTap(String collegeName) {
//     Widget? screen;
//     switch (collegeName) {
//       case 'College of Technology':
//         screen = College1Screen();
//         break;
//       case 'College of Science and Mathematics':
//         screen = College2Screen();
//         break;
//       case 'College of Information Technology and Computing':
//         screen = College3Screen();
//         break;
//       case 'College of Science and Technology Education':
//         screen = College4Screen();
//         break;
//       case 'College of Engineering and Architecture':
//         screen = College5Screen();
//         break;
//     }
//     if (screen != null) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (_) => screen!),
//       );
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _photoViewController.scale = 1.3;
//   }
//
//   @override
//   void dispose() {
//     _photoViewController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Campus Map',
//           style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color(0xFFFF971A),
//                 Color(0xFFFFFF67),
//               ],
//               transform: GradientRotation(24),
//             ),
//           ),
//         ),
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           final width = constraints.maxWidth;
//           final height = constraints.maxHeight;
//
//           return Container(
//             width: double.infinity,
//             height: double.infinity,
//             color: Colors.white,
//             child: PhotoView.customChild(
//               backgroundDecoration: BoxDecoration(color: Colors.white),
//               controller: _photoViewController,
//               initialScale: PhotoViewComputedScale.contained * 1.3,
//               minScale: PhotoViewComputedScale.contained * 0.8,
//               maxScale: PhotoViewComputedScale.covered * 3.0,
//               basePosition: Alignment.center,
//               child: Stack(
//                 children: [
//                   Image.asset(
//                     'assets/ustp-campus-map.png',
//                     fit: BoxFit.contain,
//                     width: double.infinity,
//                     height: double.infinity,
//                     alignment: Alignment.center,
//                   ),
//                   _mapButton(
//                     left: width * 0.21,
//                     top: height * 0.40,
//                     color: Colors.orange,
//                     collegeName: 'College of Technology',
//                     number: 1,
//                   ),
//                   _mapButton(
//                     left: width * 0.32,
//                     top: height * 0.50,
//                     color: Colors.green,
//                     collegeName: 'College of Science and Mathematics',
//                     number: 2,
//                   ),
//                   _mapButton(
//                     left: width * 0.67,
//                     top: height * 0.44,
//                     color: Colors.black,
//                     collegeName: 'College of Information Technology and Computing',
//                     number: 3,
//                   ),
//                   _mapButton(
//                     left: width * 0.53,
//                     top: height * 0.46,
//                     color: Colors.blue,
//                     collegeName: 'College of Science and Technology Education',
//                     number: 4,
//                   ),
//                   _mapButton(
//                     left: width * 0.55,
//                     top: height * 0.55,
//                     color: Colors.red,
//                     collegeName: 'College of Engineering and Architecture',
//                     number: 5,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _mapButton({
//     double? left,
//     double? top,
//     double? right,
//     double? bottom,
//     required Color color,
//     required String collegeName,
//     required int number,
//   }) {
//     return Positioned(
//       left: left,
//       top: top,
//       right: right,
//       bottom: bottom,
//       child: GestureDetector(
//         onTap: () => _onCollegeTap(collegeName),
//         child: AnimatedContainer(
//           duration: Duration(milliseconds: 300),
//           width: 24,
//           height: 24,
//           decoration: BoxDecoration(
//             color: color,
//             shape: BoxShape.circle,
//             boxShadow: [
//               BoxShadow(
//                 color: color.withOpacity(0.6),
//                 blurRadius: 6,
//                 spreadRadius: 1,
//               ),
//             ],
//           ),
//           child: Center(
//             child: Text(
//               '$number',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'Montserrat',
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }