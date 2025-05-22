import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class College1Screen extends StatefulWidget {
  @override
  _College1ScreenState createState() => _College1ScreenState();
}

class _College1ScreenState extends State<College1Screen> {
  final PhotoViewController _photoViewController = PhotoViewController();

  final List<String> buildings = ['Building 36', 'Building 45', 'Building 47'];

  final Map<String, List<String>> roomData = {
    'Building 47': [
      'First Floor',
      'Room 47-101 - Autotronics Lab 1',
      'Room 47-102 - Autotronics Lab 2',
      'Room 47-103 - ICET Office',
      'Room 47-104 - HIVE Lab',
      'Room 47-105 - COT Dean\'s Office',
      'Second Floor',
      'Room 47-201 - Basic Electrical and Electronic Circuits Lab 1',
      'Room 47-202 - Basic Electrical and Electronic Circuits Lab 2',
      'Room 47-203 - AutoCAD Lab',
      'Room 47-204 - Electrical Machines and Motor Controls Lab',
      'Room 47-205 - Advanced Mechatronics Lab',
      'Room 47-206 - Automation Instrumentation and Process Control Lab',
      'Room 47-207 - Communication and Digital Lab',
      'Room 47-208 - Adv. Electrical and Electronic Circuits Lab',
      'Third Floor',
      'Room 47-301 - TBA',
      'Room 47-302 - Lecture Room',
      'Room 47-303 - Lecture Room',
      'Room 47-304 - COT Library',
      'Room 47-305 - Student Council of Technology Office',
      'Room 47-306 - Storage Room',
    ],
    'Building 45': [
      'Ground Floor - Workshop Area',
      'Room 45-101 - CCTV Room',
      'Room 45-102 - CNC Room',
      'Second Floor',
      'Room 45-201 - ICET Office',
      'Room 45-202 - 3D Printing Room',
      'Room 45-203 - Northern Mindanao Metals and Engineering Innovation Center Office',
    ],
    'Building 36': ['Mechanical Laboratory'],
  };

  void _showRooms(String buildingName) {
    final rooms = roomData[buildingName];

    if (rooms == null || rooms.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(buildingName, style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black87)),
          content: Text('No room data available for this building.', style: TextStyle(fontFamily: 'Montserrat', color: Colors.black87)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close', style: TextStyle(fontFamily: 'Montserrat', color: Colors.deepOrange)), // Yellow accent
            ),
          ],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.white,
        ),
      );
      return;
    }

    final Map<String, List<String>> floorMap = {};
    String currentFloor = 'Rooms'; // Default for rooms without a specific floor header

    for (String entry in rooms) {
      final isFloorHeader = RegExp(r'^(First|Second|Third|Fourth|Fifth|Sixth|Seventh|Eighth|Ground) Floor$', caseSensitive: false)
          .hasMatch(entry) ||
          entry.toLowerCase().contains('floor');

      if (isFloorHeader) {
        currentFloor = entry;
        floorMap[currentFloor] = [];
      } else {
        floorMap.putIfAbsent(currentFloor, () => []).add(entry);
      }
    }

    showDialog(
      context: context,
      builder: (_) => DefaultTabController(
        length: floorMap.length,
        child: AlertDialog(
          title: Text(
            buildingName,
            style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: Column(
              children: [
                TabBar(
                  isScrollable: true,
                  labelColor: Colors.deepOrange, // Yellow accent for selected tab
                  unselectedLabelColor: Colors.grey[600],
                  indicatorColor: Colors.deepOrange, // Yellow accent for indicator
                  labelStyle: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(fontFamily: 'Montserrat'),
                  tabs: floorMap.keys.map((floor) => Tab(text: floor)).toList(),
                ),
                Expanded(
                  child: TabBarView(
                    children: floorMap.values.map((roomList) {
                      return ListView.builder(
                        itemCount: roomList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              child: ListTile(
                                leading: Icon(Icons.meeting_room, color: Colors.deepOrange.withOpacity(0.7)), // Yellow accent icon
                                title: Text(roomList[index], style: TextStyle(fontFamily: 'Montserrat', fontSize: 15, color: Colors.black87)),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close', style: TextStyle(fontFamily: 'Montserrat', color: Colors.deepOrange)), // Yellow accent
            ),
          ],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light grey background for a cleaner look
      appBar: AppBar(
        title: Text(
          'COT',
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.orange,
        elevation: 2, // Slight shadow for depth
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // Yellow accent for back icon
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // White background for the map
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)), // Rounded bottom corners
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                child: PhotoView(
                  controller: _photoViewController,
                  imageProvider: AssetImage('assets/college1.png'),
                  minScale: PhotoViewComputedScale.contained * 1,
                  maxScale: PhotoViewComputedScale.covered * 2,
                  backgroundDecoration: BoxDecoration(color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Select a Building to View Rooms',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: buildings.length,
              itemBuilder: (context, index) {
                final building = buildings[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                    leading: Icon(Icons.apartment, color: Colors.deepOrange), // Yellow accent icon
                    title: Text(
                      building,
                      style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepOrange.withOpacity(0.7)), // Yellow accent icon
                    onTap: () => _showRooms(building),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}