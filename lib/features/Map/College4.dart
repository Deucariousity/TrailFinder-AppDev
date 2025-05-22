import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class College4Screen extends StatefulWidget {
  @override
  _College4ScreenState createState() => _College4ScreenState();
}

class _College4ScreenState extends State<College4Screen> {
  final PhotoViewController _photoViewController = PhotoViewController();

  final List<String> buildings = [
    'Building 14',
    'Building 15',
    'Building 16',
    'Building 23',
    'Building 24',
    'Building 25',
  ];

  final Map<String, List<String>> roomData = {
    'Building 14': ['Finance and Accounting Building'],
    'Building 15': ['HRM Building'],
    'Building 16': ['DRER Memorial Hall/Gym'],
    'Building 23': [
      'First Floor',
      'Room 23-101 - Garment Section',
      'Room 23-102 - TBA',
      'Room 23-103 - Registrars Office',
      'Room 23-104 - 21st Cent. Classroom',
      'Room 23-105 - Lecture Room',
      'Room 23-106 - Computer Science Dept.',
      'Room 23-107 - Office of Comm. Arts, Language and Literature',
      'Second Floor',
      'Room 23-201 - CITL Office',
      'Room 23-202 - E-Library',
      'Room 23-203 - Graduate Library',
      'Room 23-204 - Office of the Director for Library and Audio-Visual Services',
      'Third Floor',
      'Room 23-301 - Main Library',
      'Room 23-302 - TBA',
      'Fourth Floor',
      'Room 23-401 - Office for Innovation and Technology Solutions',
      'Room 23-402 - Innovation Tech Conference Room',
      'Room 23-403 - NTC Electronic Data Governance',
      'Room 23-404 - Bamboo Research and Innovation Center',
      'Room 23-405 - Mindanao Institute for Water Research',
      'Room 23-406 - USTP Balubal/Registrar Office',
      'Fifth Floor',
      'Room 23-501 - Mrs. Libed Office',
      'Room 23-502 - Renewable Lab 1',
      'Room 23-503 - Renewable Lab 2',
      'Room 23-504 - Affiliated Renewable Energy Center',
    ],
    'Building 24': [
      'Room 24-101 - Culinary Arts Lab 1',
      'Room 24-102 - Autotronics Lecture Room',
      'Room 24-103 - Laboratory',
      'Room 24-104 - Faculty Office',
      'Room 24-105 - EPAS Lab',
      'Room 24-106 - EPAS NCII Lecture Room',
      'Room 24-107 - Drawing Room',
    ],
    'Building 25': [
      'First Floor',
      'Room 25-101 - Lecture Room',
      'Room 25-102 - Lecture Room',
      'Room 25-103 - Lecture Room',
      'Second Floor',
      'Room 25-201 - Food Tech Lab',
      'Room 25-202 - Food Tech Lab',
      'Room 25-203 - Food Tech Lab',
    ],
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
              child: Text('Close', style: TextStyle(fontFamily: 'Montserrat', color: Colors.blue[700])), // Blue accent
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
                  labelColor: Colors.blue[700], // Blue accent for selected tab
                  unselectedLabelColor: Colors.grey[600],
                  indicatorColor: Colors.blue[700], // Blue accent for indicator
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
                                leading: Icon(Icons.meeting_room, color: Colors.blue.withOpacity(0.7)), // Blue accent icon
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
              child: Text('Close', style: TextStyle(fontFamily: 'Montserrat', color: Colors.blue[700])), // Blue accent
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
          'CSTE',
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.blue, // White app bar
        elevation: 2, // Slight shadow for depth
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
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
                  imageProvider: AssetImage('assets/college4.png'),
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
                    leading: Icon(Icons.apartment, color: Colors.blue[700]), // Blue accent icon
                    title: Text(
                      building,
                      style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue.withOpacity(0.7)), // Blue accent icon
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