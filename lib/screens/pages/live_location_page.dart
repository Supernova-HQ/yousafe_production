import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:yousafe/screens/pages/sos_request.dart';

class LiveLocationPage extends StatefulWidget {
  @override
  _LiveLocationPageState createState() => _LiveLocationPageState();
}

class _LiveLocationPageState extends State<LiveLocationPage> {
  final Location location = Location();
  LocationData? currentLocation;
  GoogleMapController? mapController;
  CameraPosition? initialCameraPosition;
  LatLng? currentLatLng;
  Set<Circle> _circles = {};

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((LocationData newLocation) {
      setState(() {
        currentLocation = newLocation;
        currentLatLng = LatLng(newLocation.latitude!, newLocation.longitude!);
        initialCameraPosition = CameraPosition(
          target: currentLatLng ?? LatLng(0, 0),
          zoom: 16.0,
        );
        _updateCircles();
        if (mapController != null) {
          mapController!.animateCamera(CameraUpdate.newCameraPosition(initialCameraPosition!));
        }
      });
    });
  }

  void _updateCircles() {
    _circles.clear();
    if (currentLatLng != null) {
      _circles.add(
        Circle(
          circleId: CircleId('userLocationCircle'),
          center: currentLatLng!,
          radius: 200.0,
          fillColor: Colors.green.withOpacity(0.3),
          strokeWidth: 4,
          strokeColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          currentLocation == null
              ? Center(child: CircularProgressIndicator())
              : GoogleMap(
                  initialCameraPosition: initialCameraPosition!,
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  circles: _circles,
                ),
          Positioned(
            bottom: 90,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 80,
                height: 80,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SOSRequestWidget()),
                  );
                    print('SOS button pressed');
                  },
                  child: Text(
                    'SOS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Colors.red,
                  shape: CircleBorder(),
                  heroTag: 'sos_button',
                  elevation: 4,
                  splashColor: Colors.redAccent,
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 90,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Share Live Location'),
                            content: Text('Your live location will be shared with your emergency contacts.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Proceed'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    backgroundColor: Colors.purple,
                    child: Icon(Icons.share, color: Colors.white),
                    heroTag: 'share_button',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}