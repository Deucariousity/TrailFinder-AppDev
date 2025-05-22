// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
//
// class CampusMapScreen extends StatefulWidget {
//   @override
//   _CampusMapScreenState createState() => _CampusMapScreenState();
// }
//
// class _CampusMapScreenState extends State<CampusMapScreen> {
//   String? selectedArea;
//   final PhotoViewController _photoViewController = PhotoViewController();
//
//   Map<String, List<String>> buildingData = {
//     'College of Technology': ['Building 36', 'Building 45', 'Building 47'],
//     'College of Science and Mathematics': ['Building 27', 'Building 28', 'Building 41'],
//     'College of Information Technology and Computing': ['Building 3', 'Building 9', 'Building 10'],
//     'College of Science and Technology Education': ['Building 14', 'Building 15', 'Building 16', 'Building 23', 'Building 24', 'Building 25'],
//     'College of Engineering and Architecture': ['Building 4', 'Building 5', 'Building 18', 'Building 19', 'Building 20','Building 42', 'Building 43'],
//   };
//
//   // Buildings with floors and number of floors
//   final Map<String, int> buildingsWithFloors = {
//     'Building 45': 2,
//     'Building 47': 3,
//     'Building 23': 5,
//     'Building 25': 2,
//     'Building 27': 2,
//     'Building 41': 5,
//     'Building 9': 4,
//     'Building 42': 6,
//     'Building 43': 8,
//   };
//
//   // Buildings that have no rooms
//   final Set<String> buildingsWithoutRooms = {
//     'Building 36',
//     'Building 14',
//     'Building 15',
//     'Building 16',
//     'Building 26',
//     'Building 3',
//     'Building 10',
//     'Building 20',
//   };
//
//   void _showBuildings(String collegeName) {
//     setState(() {
//       selectedArea = collegeName;
//     });
//   }
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
//     'Building 9': [
//       'First Floor',
//       'Room 9-101 - CITC Dean\'s Office',
//       'Room 9-102 - StratComm Office',
//       'Room 9-103 - Multiple Offices',
//       'Room 9-104 - Infrastructure Planning and Facilities Development Office',
//       'Room 9-105 - International Affairs Office',
//       'Room 9-106 - Career Center',
//       'Room 9-107 - ICPeP Office',
//       'Second Floor',
//       'Room 9-201 - Digital Transformation Office',
//       'Room 9-202 - Multimedia Lab',
//       'Room 9-203 - JEEP Start Lab',
//       'Room 9-204 - Multimedia Lab',
//       'Room 9-205 - Data Sci. Lab',
//       'Room 9-206 - Center for Data Science and Technological Innovation',
//       'Room 9-207 - Data Sci. Dept.',
//       'Room 9-208 - TCM Dept.',
//       'Room 9-209 - ESU Office',
//       'Third Floor',
//       'Room 9-301 - ICT Office',
//       'Room 9-302 - Computer Lab',
//       'Room 9-303 - Computer Lab',
//       'Room 9-304 - Computer Lab',
//       'Room 9-305 - Computer Lab',
//       'Room 9-306 - Computer Lab',
//       'Room 9-307 - Computer Lab',
//       'Room 9-308 - Computer Lab',
//       'Room 9-309 - Computer Lab',
//       'Room 9-310 - Computer Lab',
//       'Fourth Floor',
//       'Room 9-401 - IT Dept.',
//       'Room 9-402 - Lecture Room',
//       'Room 9-403 - Lecture Room',
//       'Room 9-404 - Lecture Room',
//       'Room 9-405 - ICT AVR',
//     ],
//     'Building 42': [
//       'First Floor',
//       'Room 42-101 - Research Director Office',
//       'Room 42-102 - IGIS Office',
//       'Second Floor',
//       'Room 42-201 - Mechanical Eng. Lab',
//       'Room 42-202 - Power Electronics Lab',
//       'Room 42-203 - Microelectronics Lab',
//       'Room 42-204 - Electrical Eng. Lab',
//       'Third Floor',
//       'Room 42-301 - Lecture Room',
//       'Room 42-302 - Lecture Room',
//       'Room 42-303 - Lecture Room',
//       'Room 42-304 - Lecture Room',
//       'Fourth Floor',
//       'Room 42-401 - SMART Classroom',
//       'Room 42-402 - Testing Center',
//       'Room 42-403 - Multimedia Lab',
//       'Room 42-404 - DTL, DSPED, DEPA Office',
//       'Fifth Floor',
//       'Room 42-501 - CSTE Dean\'s Office',
//       'Room 42-502 - Science Education Dept.',
//       'Room 42-503 - Math Education Dept.',
//       'Room 42-504 - TLE and Teacher Technician Education Dept.',
//       'Sixth Floor',
//       'Room 42-601 - PAT AVR',
//     ],
//     'Building 23': [
//       'First Floor',
//       'Room 23-101 - Garment Section',
//       'Room 23-102 - TBA',
//       'Room 23-103 - Registrars Office',
//       'Room 23-104 - 21st Cent. Classroom',
//       'Room 23-105 - Lecture Room',
//       'Room 23-106 - Computer Science Dept.',
//       'Room 23-107 - Office of Comm. Arts, Language and Literature',
//       'Second Floor',
//       'Room 23-201 - CITL Office',
//       'Room 23-202 - E-Library',
//       'Room 23-203 - Graduate Library',
//       'Room 23-204 - Office of the Director for Library and Audio-Visual Services',
//       'Third Floor',
//       'Room 23-301 - Main Library',
//       'Room 23-302 - TBA',
//       'Fourth Floor',
//       'Room 23-401 - Office  for Innovation and Technology Solutions',
//       'Room 23-402 - Office  for Innovation and Technology Solutions Conference Room',
//       'Room 23-403 - NTC Elctronic data governance and evaluation office',
//       'Room 23-404 - Bamboo research and innovation center',
//       'Room 23-405 - Mindanao Institute for Water Research',
//       'Room 23-406 - USTP Balubal Extenstion Office/USTP System Registrar',
//       'Fifth Floor',
//       'Room 23-501 - Mrs. Libed Office',
//       'Room 23-502 - Renewable Lab 1',
//       'Room 23-503 - Renewable Lab 2',
//       'Room 23-504 - Affiliated Renewable Energy Center',
//     ],
//     'Building 41': [
//       'First Floor',
//       'Room 41-101 - Guidance Service Office',
//       'Room 41-102 - Admission and Scholarship Office',
//       'Room 41-103 - Inorganic and Industrial Chem Lab',
//       'Room 41-104 - Social Science Office',
//       'Room 41-105 - CSM Library',
//       'Room 41-106 - USTP Alubijid Sub Office',
//       'Room 41-107 - Office of Vice Chancellor for Academic  Affairs',
//       'Second Floor',
//       'Room 41-201 - Instruments Lab 1',
//       'Room 41-202 - Instruments Lab 2',
//       'Room 41-203 - Heating and Related Facilities Lab',
//       'Room 41-204 - Center for Research and Adv. Sciences',
//       'Room 41-205 - Instruments Lab 3',
//       'Room 41-206 - Chem. Research Lab',
//       'Room 41-207A - Testing Lab',
//       'Room 41-207B - Chemistry Dept.',
//       'Third Floor',
//       'Room 41-301 - Physics Lab',
//       'Room 41-302 - Instrument Room',
//       'Room 41-303 - Physics Lab',
//       'Room 41-304 - Physics Lab/FST Research Lab',
//       'Room 41-305 - FST Stockroom',
//       'Room 41-306 - FST research lab',
//       'Room 41-307A - Physics Dept.',
//       'Room 41-307B - Applied Physics Dept.',
//       'Fourth Floor',
//       'Room 41-401 - Applied Math Dept.',
//       'Room 41-402 - EST Lab',
//       'Room 41-403 - Envi Microbiology and Thesis Lab',
//       'Room 41-404 - ES Lab',
//       'Room 41-405 - Food Prep. Lab',
//       'Room 41-406 - Physics Lab',
//       'Room 41-407 - EST and FST Dept.',
//       'Fifth Floor',
//       'Room 41-501 - Chem Lab',
//       'Room 41-502 - Chem Prep Room',
//       'Room 41-503 - Stock Room',
//       'Room 41-504 - Chem Lab',
//       'Room 41-505 - Chem Lab',
//       'Room 41-506 - Biochem and Organic Lab',
//       'Room 41-507 - CSM Dean\'s Office',
//     ],
//     'Building 43': [
//       'First Floor',
//       'Room 43-101 - CEA Dean\'s Office',
//       'Room 43-102 - Accreditation Office',
//       'Room 43-103 - Civil Eng. Dept',
//       'Second Floor',
//       'Room 43-201 - ECRD Office',
//       'Room 43-202 - CEA Library',
//       'Third Floor',
//       'Room 43-301 - Electronics Eng. Dept',
//       'Room 43-302 - Computer Eng. Dept',
//       'Room 43-303 - Electrical Eng. Dept',
//       'Fourth Floor',
//       'Room 43-401 - USTP Villanueva Campus Sub Office',
//       'Room 43-402 - Printing Press',
//       'Room 43-403 - Lecture Room',
//       'Fifth Floor',
//       'Room 43-501 - Chancellors Office',
//       'Room 43-502 - Conference Room',
//       'Sixth Floor',
//       'Room 43-601 - Drawing Room',
//       'Room 43-602 - Drawing Room',
//       'Seventh Floor',
//       'Room 43-701 - Architecture Dept.',
//       'Room 43-702 - CADD Lab',
//       'Room 43-703 - MatLab Lab',
//       'Eighth Floor',
//       'Room 43-801 - Mechanical Eng. Dept ',
//       'Room 43-802 - Studio Room',
//       'Room 43-803 - Studio Room',
//     ],
//     'Building 28': [
//       'Room 28-101 - Lecture Room',
//       'Room 28-102 - Lecture Room',
//       'Room 28-103 - Lecture Room',
//       'Room 28-104 - Lecture Room',
//       'Room 28-105 - Lecture Room',
//       'Room 28-106 - Lecture Room',
//       'Room 28-107 - Lecture Room',
//       'Room 28-108 - Lecture Room',
//       'Room 28-109 - Lecture Room',
//       'Room 28-110 - Lecture Room',
//       'Room 28-111 - Laboratory Management Office',
//     ],
//     'Building 5': [
//       'Room 5-101 - Lecture Room',
//       'Room 5-102 - Lecture Room',
//       'Room 5-103 - Lecture Room',
//       'Room 5-104 - Lecture Room',
//       'Room 5-105 - Lecture Room',
//       'Room 5-106 - Lecture Room',
//       'Room 5-107 - Lecture Room',
//       'Room 5-108 - Lecture Room',
//       'Room 5-109 - Lecture Room',
//     ],
//     'Building 24': [
//       'Room 24-101 - Culinary Arts Lab 1',
//       'Room 24-102 - Autotronics Lecture Room',
//       'Room 24-103 - Laboratory',
//       'Room 24-104 - Faculty Office',
//       'Room 24-105 - EPAS Lab',
//       'Room 24-106 - Lecture Room(Electronic Products Assembly and Servicing NC11)',
//       'Room 24-107 - Drawing Room',
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
//     'Building 25': [
//       'First Floor',
//       'Room 25-101 - Lecture Room',
//       'Room 25-102 - Lecture Room',
//       'Room 25-103 - Lecture Room',
//       'Second Floor',
//       'Room 25-201 - Food Tech Lab',
//       'Room 25-202 - Food Tech Lab',
//       'Room 25-203 - Food Tech Lab',
//     ],
//     'Building 18': [
//       'Room 18-101 - Culinary Lab',
//       'Room 18-102 - Culinary Lab',
//       'Room 18-103 - Culinary Lab',
//     ],
//     'Building 19': [
//       'Room 19-101 - ROTC Office',
//       'Room 19-102 - NSTP Office',
//       'Room 19-103 - ROTC Armory',
//     ],
//     'Building 27': [
//       'First Floor',
//       'Clinic',
//       'University Health Center',
//       'College of Medicine Dept.',
//       'Second Floor',
//       'OSA Office',
//     ],
//     'Building 4': ['Room 4-101 - Lecture Room'],
//     'Building 20': ['Cafeteria'],
//     'Building 36': ['Mechanical Laboratory'],
//     'Building 10': ['Administration Building'],
//     'Building 3': ['College of Medicine Building'],
//     'Building 26': ['Food Innovation Center'],
//     'Building 14': ['Finance and Accounting Building'],
//     'Building 15': ['HRM Building'],
//     'Building 16': ['DRER Memorial Hall/Gym'],
//
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
//     // Parse floors and corresponding room lists
//     final Map<String, List<String>> floorMap = {};
//     String currentFloor = 'Rooms';
//
//     for (String entry in rooms) {
//       final isFloorHeader = RegExp(r'^(First|Second|Third|Fourth|Fifth|Sixth|Seventh|Eighth|Ground) Floor$', caseSensitive: false)
//           .hasMatch(entry) || entry.toLowerCase().contains('floor');
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
//       body: selectedArea == null ? _buildMap() : _buildBuildingsList(),
//     );
//   }
//
//   Widget _buildMap() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final width = constraints.maxWidth;
//         final height = constraints.maxHeight;
//
//         return Container(
//           width: double.infinity,
//           height: double.infinity,
//           color: Colors.white,
//           child: PhotoView.customChild(
//             backgroundDecoration: BoxDecoration(color: Colors.white),
//             controller: _photoViewController,
//             initialScale: PhotoViewComputedScale.contained * 1.3,
//             minScale: PhotoViewComputedScale.contained * 0.8,
//             maxScale: PhotoViewComputedScale.covered * 3.0,
//             basePosition: Alignment.center,
//             child: Stack(
//               children: [
//                 Image.asset(
//                   'assets/ustp-campus-map.png',
//                   fit: BoxFit.contain,
//                   width: double.infinity,
//                   height: double.infinity,
//                   alignment: Alignment.center,
//                 ),
//                 _mapButton(
//                   left: width * 0.21,
//                   top: height * 0.40,
//                   color: Colors.orange,
//                   collegeName: 'College of Technology',
//                   number: 1,
//                 ),
//                 _mapButton(
//                   left: width * 0.32,
//                   top: height * 0.50,
//                   color: Colors.green,
//                   collegeName: 'College of Science and Mathematics',
//                   number: 2,
//                 ),
//                 _mapButton(
//                   left: width * 0.67,
//                   top: height * 0.44,
//                   color: Colors.black,
//                   collegeName: 'College of Information Technology and Computing',
//                   number: 3,
//                 ),
//                 _mapButton(
//                   left: width * 0.53,
//                   top: height * 0.46,
//                   color: Colors.blue,
//                   collegeName: 'College of Science and Technology Education',
//                   number: 4,
//                 ),
//                 _mapButton(
//                   left: width * 0.55,
//                   top: height * 0.55,
//                   color: Colors.red,
//                   collegeName: 'College of Engineering and Architecture',
//                   number: 5,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
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
//         onTap: () => _showBuildings(collegeName),
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
//                   color: Colors.white,
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Montserrat'
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBuildingsList() {
//     return Column(
//       children: [
//         Container(
//           width: double.infinity,
//           padding: EdgeInsets.symmetric(horizontal: 8),
//           color: Colors.orange,
//           child: SafeArea(
//             child: Row(
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.arrow_back, color: Colors.white),
//                   onPressed: () {
//                     setState(() {
//                       selectedArea = null;
//                     });
//                   },
//                 ),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: Text(
//                     selectedArea ?? '',
//                     style: TextStyle(
//                       fontFamily: 'Montserrat',
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                       color: Colors.white,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Expanded(
//           child: ListView(
//             padding: EdgeInsets.all(16),
//             children: buildingData[selectedArea]!.map((building) {
//               return ListTile(
//                 title: Text(
//                   building,
//                   style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
//                 ),
//                 trailing: Icon(Icons.arrow_forward_ios),
//                 onTap: () => _showRooms(building),
//               );
//             }).toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }