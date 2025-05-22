// import 'package:flutter/material.dart';
//
// class CollegeBuildings extends StatelessWidget {
//   const CollegeBuildings({Key? key}) : super(key: key);
//
//   final List<Map<String, String>> buildings = const [
//     {'name': 'Engineering Building', 'description': 'Houses labs and classrooms for engineering programs.'},
//     {'name': 'IT Building', 'description': 'Contains computer labs and tech facilities for CS and IT students.'},
//     {'name': 'Business Center', 'description': 'Main hub for business courses and entrepreneurship programs.'},
//     {'name': 'Education Hall', 'description': 'Used by education majors for training and lectures.'},
//     {'name': 'Science Complex', 'description': 'Science departments with research facilities and labs.'},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('College Buildings'),
//       ),
//       body: ListView.builder(
//         itemCount: buildings.length,
//         itemBuilder: (context, index) {
//           final building = buildings[index];
//           return Card(
//             margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: ListTile(
//               title: Text(building['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
//               subtitle: Text(building['description']!),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
