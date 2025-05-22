import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class College3Screen extends StatefulWidget {
  @override
  _College3ScreenState createState() => _College3ScreenState();
}

class _College3ScreenState extends State<College3Screen> {
  final PhotoViewController _photoViewController = PhotoViewController();

  final List<String> buildings = ['Building 3', 'Building 9', 'Building 10'];

  final Map<String, List<String>> roomData = {
    'Building 9': [
      'First Floor',
      'Room 9-101 - CITC Dean\'s Office',
      'Room 9-102 - StratComm Office',
      'Room 9-103 - Multiple Offices',
      'Room 9-104 - Infrastructure Planning and Facilities Development Office',
      'Room 9-105 - International Affairs Office',
      'Room 9-106 - Career Center',
      'Room 9-107 - ICPeP Office',
      'Second Floor',
      'Room 9-201 - Digital Transformation Office',
      'Room 9-202 - Multimedia Lab',
      'Room 9-203 - JEEP Start Lab',
      'Room 9-204 - Multimedia Lab',
      'Room 9-205 - Data Sci. Lab',
      'Room 9-206 - Center for Data Science and Technological Innovation',
      'Room 9-207 - Data Sci. Dept.',
      'Room 9-208 - TCM Dept.',
      'Room 9-209 - ESU Office',
      'Third Floor',
      'Room 9-301 - ICT Office',
      'Room 9-302 - Computer Lab',
      'Room 9-303 - Computer Lab',
      'Room 9-304 - Computer Lab',
      'Room 9-305 - Computer Lab',
      'Room 9-306 - Computer Lab',
      'Room 9-307 - Computer Lab',
      'Room 9-308 - Computer Lab',
      'Room 9-309 - Computer Lab',
      'Room 9-310 - Computer Lab',
      'Fourth Floor',
      'Room 9-401 - IT Dept.',
      'Room 9-402 - Lecture Room',
      'Room 9-403 - Lecture Room',
      'Room 9-404 - Lecture Room',
      'Room 9-405 - ICT AVR',
    ],
    'Building 3': ['College of Medicine Building'],
    'Building 10': ['Administration Building'],
  };

  void _showRooms(String buildingName) {
    final rooms = roomData[buildingName];

    if (rooms == null || rooms.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            buildingName,
            style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          content: Text('No room data available for this building.',
              style: TextStyle(fontFamily: 'Montserrat', color: Colors.black87)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close', style: TextStyle(fontFamily: 'Montserrat', color: Colors.black)),
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
      final isFloorHeader = RegExp(
        r'^(First|Second|Third|Fourth|Fifth|Sixth|Seventh|Eighth|Ground) Floor$',
        caseSensitive: false,
      ).hasMatch(entry) || entry.toLowerCase().contains('floor');

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
                  labelColor: Colors.black, // Black for selected tab
                  unselectedLabelColor: Colors.grey[600],
                  indicatorColor: Colors.black, // Black for indicator
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
                              color: Colors.white, // White card background
                              child: ListTile(
                                leading: Icon(Icons.meeting_room, color: Colors.black54), // Black icon
                                title: Text(roomList[index],
                                    style:
                                    TextStyle(fontFamily: 'Montserrat', fontSize: 15, color: Colors.black87)),
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
              child: Text('Close', style: TextStyle(fontFamily: 'Montserrat', color: Colors.black)),
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
      backgroundColor: Colors.white, // White background for a clean look
      appBar: AppBar(
        title: Text(
          'CITC',
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 2, // Subtle shadow for depth
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
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
                    color: Colors.grey.withOpacity(0.3), // Darker shadow for contrast
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
                  imageProvider: AssetImage('assets/college3.png'),
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
                  color: Colors.white, // White card background
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                    leading: Icon(Icons.apartment, color: Colors.black87), // Black icon
                    title: Text(
                      building,
                      style: TextStyle(
                          fontFamily: 'Montserrat', fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.black54), // Black icon
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