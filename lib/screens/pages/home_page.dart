import 'package:flutter/material.dart';
import 'package:yousafe/screens/pages/emergency_contacts_page.dart';
import 'package:yousafe/screens/pages/hotspots_page.dart';
import 'package:yousafe/screens/pages/live_location_page.dart';
import 'package:yousafe/screens/pages/notifications_page.dart';
import 'package:yousafe/screens/pages/profile_page.dart';
import 'package:yousafe/screens/pages/retrieve_contacts_page.dart';
import 'package:yousafe/screens/pages/sos_home_page.dart';
import 'package:yousafe/screens/pages/sos_request.dart';
import 'package:yousafe/screens/pages/onboarding_overlay.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isFirstLaunch = true;
  final List<Widget> _pages = [
    SOSHomePage(),
    RetrieveContactsPage(),
    LiveLocationPage(),
    ProfilePage(),
  ];

  void _onOnboardingFinished() {
    setState(() {
      _isFirstLaunch = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: _isFirstLaunch
          ? OnboardingOverlay(onFinished: _onOnboardingFinished)
          : BottomAppBar(
              color: Colors.white,
              shape: CircularNotchedRectangle(),
              notchMargin: 6.0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBottomNavItem(Icons.home, 'Home', 0),
                  _buildBottomNavItem(Icons.contacts, 'Contacts', 1),
                  _buildBottomNavItem(Icons.map, 'Live Location', 2),
                  _buildBottomNavItem(Icons.person, 'Profile', 3),
                ],
              ),
            ),
      extendBody: true,
      resizeToAvoidBottomInset: true,
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, int index) {
    Color color = _selectedIndex == index ? Colors.purple : Colors.black87;
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            Text(label, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}