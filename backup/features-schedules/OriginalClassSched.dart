// import 'package:flutter/material.dart';
// import 'package:TrailFinder/custom_page_route.dart';
// import 'AddSchedule.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
//
// class ViewSchedulesScreen extends StatefulWidget {
//   final List<String> schedules;
//   final Function(List<String>) onScheduleUpdated;
//
//   ViewSchedulesScreen({required this.schedules, required this.onScheduleUpdated});
//
//   @override
//   _ViewSchedulesScreenState createState() => _ViewSchedulesScreenState();
// }
//
// class _ViewSchedulesScreenState extends State<ViewSchedulesScreen> {
//   final List<String> daysOfWeek = [
//     "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
//   ];
//
//   Map<String, List<String>> _groupSchedulesByDay(List<String> schedules) {
//     Map<String, List<String>> dayMap = { for (var day in daysOfWeek) day: [] };
//     for (var schedule in schedules) {
//       for (var day in daysOfWeek) {
//         if (schedule.startsWith(day)) {
//           dayMap[day]?.add(schedule);
//         }
//       }
//     }
//     return dayMap;
//   }
//
//   void _navigateToAddSchedule([String? day]) {
//     Navigator.push(
//       context,
//       CustomPageRoute(
//         page: AddScheduleScreen(
//           onScheduleAdded: (newSchedules) {
//             setState(() {
//               widget.schedules.addAll(newSchedules);
//               widget.onScheduleUpdated(widget.schedules);
//             });
//           },
//           prefillDay: day,
//         ),
//       ),
//     );
//   }
//
//   void _showScheduleDetailsDialog(String schedule) {
//     final parts = schedule.split(" - ");
//     final course = parts.length > 1 ? parts[1] : "Unknown";
//     final time = parts.length > 3 ? "${parts[2]} – ${parts[3]}" : "";
//     final room = parts.length > 4 ? parts[4] : "";
//
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(course, style: TextStyle(fontFamily: 'Montserrat')),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Time: $time", style: TextStyle(fontFamily: 'Montserrat')),
//             Text("Location: $room", style: TextStyle(fontFamily: 'Montserrat')),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text("Close"),
//           ),
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 widget.schedules.remove(schedule);
//                 widget.onScheduleUpdated(widget.schedules);
//               });
//               Navigator.pop(context);
//             },
//             style: TextButton.styleFrom(foregroundColor: Colors.red),
//             child: Text("Delete"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final daySchedules = _groupSchedulesByDay(widget.schedules);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Class Schedules', style: TextStyle(fontSize: 20, fontFamily: 'Montserrat', color: Colors.black)),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFFFF971A), Color(0xFFFFFF67)],
//               transform: GradientRotation(24),
//             ),
//           ),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/features-background.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: ListView.builder(
//           itemCount: daysOfWeek.length,
//           itemBuilder: (context, index) {
//             final day = daysOfWeek[index];
//             final schedules = daySchedules[day] ?? [];
//
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     day,
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'Montserrat',
//                       color: Colors.black,
//                     ),
//                   ),
//                   if (schedules.isEmpty)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 4.0, left: 10),
//                       child: GestureDetector(
//                         onTap: () => _navigateToAddSchedule(day),
//                         child: Container(
//                           padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.85),
//                             borderRadius: BorderRadius.circular(16),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.05),
//                                 blurRadius: 3,
//                                 offset: Offset(1, 1),
//                               ),
//                             ],
//                           ),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(Icons.add, size: 18, color: Colors.black.withOpacity(0.5)),
//                               SizedBox(width: 6),
//                               Text(
//                                 "Add a schedule for this day",
//                                 style: TextStyle(
//                                   fontStyle: FontStyle.italic,
//                                   color: Colors.black.withOpacity(0.6),
//                                   fontFamily: 'Montserrat',
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     )
//                   else
//                     ...schedules.asMap().entries.map((entry) {
//                       final i = entry.key;
//                       final schedule = entry.value;
//
//                       final parts = schedule.split(" - ");
//                       final course = parts.length > 1 ? parts[1] : "Unknown";
//                       final time = parts.length > 3 ? "${parts[2]} – ${parts[3]}" : "";
//                       final room = parts.length > 4 ? parts[4] : "";
//
//                       return GestureDetector(
//                         onTap: () => _showScheduleDetailsDialog(schedule),
//                         child: Container(
//                           margin: const EdgeInsets.only(top: 6, left: 10),
//                           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.85),
//                             borderRadius: BorderRadius.circular(16),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.1),
//                                 blurRadius: 4,
//                                 offset: Offset(2, 2),
//                               ),
//                             ],
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   "$course   |   $time   |   $room",
//                                   style: TextStyle(fontFamily: 'Montserrat', color: Colors.black),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                               if (i == schedules.length - 1)
//                                 GestureDetector(
//                                   onTap: () => _navigateToAddSchedule(day),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(left: 8.0),
//                                     child: Icon(Icons.add, size: 18, color: Colors.black.withOpacity(0.6)),
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }