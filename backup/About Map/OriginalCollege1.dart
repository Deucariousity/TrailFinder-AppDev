// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
//
// class College1Screen extends StatefulWidget {
//   @override
//   _College1ScreenState createState() => _College1ScreenState();
// }
//
// class _College1ScreenState extends State<College1Screen> {
//   final PhotoViewController _photoViewController = PhotoViewController();
//
//   final List<String> buildings = ['Building 36', 'Building 45', 'Building 47'];
//
//   final Map<String, List<String>> roomData = {
//     'Building 47': [
//       'First Floor',
//       'Room 47-101 - Autotronics Lab 1',
//       'Room 47-102 - Autotronics Lab 2',
//       'Room 47-103 - ICET Office',
//       'Room 47-104 - HIVE Lab',
//       'Room 47-105 - COT Dean\'s Office',
//       'Second Floor',
//       'Room 47-201 - Basic Electrical and Electronic Circuits Lab 1',
//       'Room 47-202 - Basic Electrical and Electronic Circuits Lab 2',
//       'Room 47-203 - AutoCAD Lab',
//       'Room 47-204 - Electrical Machines and Motor Controls Lab',
//       'Room 47-205 - Advanced Mechatronics Lab',
//       'Room 47-206 - Automation Instrumentation and Process Control Lab',
//       'Room 47-207 - Communication and Digital Lab',
//       'Room 47-208 - Adv. Electrical and Electronic Circuits Lab',
//       'Third Floor',
//       'Room 47-301 - TBA',
//       'Room 47-302 - Lecture Room',
//       'Room 47-303 - Lecture Room',
//       'Room 47-304 - COT Library',
//       'Room 47-305 - Student Council of Technology Office',
//       'Room 47-306 - Storage Room',
//     ],
//     'Building 45': [
//       'Ground Floor - Workshop Area',
//       'Room 45-101 - CCTV Room',
//       'Room 45-102 - CNC Room',
//       'Second Floor',
//       'Room 45-201 - ICET Office',
//       'Room 45-202 - 3D Printing Room',
//       'Room 45-203 - Northern Mindanao Metals and Engineering Innovation Center Office',
//     ],
//     'Building 36': ['Mechanical Laboratory'],
//   };
//
//   void _showRooms(String buildingName) {
//     final rooms = roomData[buildingName];
//
//     if (rooms == null || rooms.isEmpty) {
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: Text(buildingName),
//           content: Text('No room data available.'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('Close'),
//             ),
//           ],
//         ),
//       );
//       return;
//     }
//
//     final Map<String, List<String>> floorMap = {};
//     String currentFloor = 'Rooms';
//
//     for (String entry in rooms) {
//       final isFloorHeader = RegExp(r'^(First|Second|Third|Fourth|Fifth|Sixth|Seventh|Eighth|Ground) Floor$', caseSensitive: false)
//           .hasMatch(entry) ||
//           entry.toLowerCase().contains('floor');
//
//       if (isFloorHeader) {
//         currentFloor = entry;
//         floorMap[currentFloor] = [];
//       } else {
//         floorMap.putIfAbsent(currentFloor, () => []).add(entry);
//       }
//     }
//
//     showDialog(
//       context: context,
//       builder: (_) => DefaultTabController(
//         length: floorMap.length,
//         child: AlertDialog(
//           title: Text(buildingName, style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
//           content: SizedBox(
//             width: double.maxFinite,
//             height: 400,
//             child: Column(
//               children: [
//                 TabBar(
//                   isScrollable: true,
//                   labelColor: Theme.of(context).primaryColor,
//                   unselectedLabelColor: Colors.grey,
//                   tabs: floorMap.keys.map((floor) => Tab(text: floor)).toList(),
//                 ),
//                 Expanded(
//                   child: TabBarView(
//                     children: floorMap.values.map((roomList) {
//                       return ListView(
//                         children: roomList
//                             .map((room) => ListTile(title: Text(room, style: TextStyle(fontFamily: 'Montserrat'))))
//                             .toList(),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('Close', style: TextStyle(fontFamily: 'Montserrat')),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'College of Technology',
//           style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             flex: 2,
//             child: ClipRect(
//               child: PhotoView(
//                 controller: _photoViewController,
//                 imageProvider: AssetImage('assets/college1.png'), // Replace with your college-specific map
//                 minScale: PhotoViewComputedScale.contained * 1,
//                 maxScale: PhotoViewComputedScale.covered * 2,
//                 backgroundDecoration: BoxDecoration(color: Colors.white),
//               ),
//             ),
//           ),
//           Divider(),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'Select a Building to View Rooms',
//               style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: ListView(
//               children: buildings.map((building) {
//                 return ListTile(
//                   title: Text(
//                     building,
//                     style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
//                   ),
//                   trailing: Icon(Icons.arrow_forward_ios),
//                   onTap: () => _showRooms(building),
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
