import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HotspotsPage extends StatefulWidget {
  @override
  _HotspotsPageState createState() => _HotspotsPageState();
}

class _HotspotsPageState extends State<HotspotsPage> {
  late GoogleMapController _mapController;
  LatLng? _currentLocation;
  Location _location = Location();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationData locationData = await _location.getLocation();
    setState(() {
      _currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _currentLocation!,
                zoom: 15.0,
              ),
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              circles: Set.from([
                Circle(
                  circleId: CircleId('user_radius'),
                  center: _currentLocation!,
                  radius: 1000,
                  strokeColor: Colors.green,
                  strokeWidth: 2,
                  fillColor: Colors.green.withOpacity(0.2),
                ),
              ]),
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // Handle share button press
              print('Share button pressed');
            },
            child: Icon(Icons.share),
            backgroundColor: Colors.blue,
            heroTag: 'share_button',
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              // Handle SOS button press
              print('SOS button pressed');
            },
            child: Text('SOS'),
            backgroundColor: Colors.red,
            shape: CircleBorder(),
            heroTag: 'sos_button',
          ),
        ],
      ),
    );
  }
}