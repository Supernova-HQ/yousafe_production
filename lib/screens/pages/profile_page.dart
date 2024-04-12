import 'package:flutter/material.dart';
import 'package:yousafe/screens/pages/payments_page.dart';
import 'package:yousafe/screens/pages/trauma_booking.dart';
import 'edit_profile.dart'; // Import the EditProfilePage
import 'emergency_contacts_page.dart'; // Import the EmergencyContactsPage
import 'package:yousafe/screens/auth/login_screen.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profile',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0), // Added some space between sections
            const Text(
              'Account Settings',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15.0),
            SettingOption(
              text: 'Personal information',
              icon: Icons.person,
              onTap: () {
                // Navigate to EditProfilePage when tapped
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
              },
            ),
            SettingOption(
              text: 'Emergency Contacts',
              icon: Icons.emergency,
              onTap: () {
                // Navigate to EmergencyContactsPage when tapped
                Navigator.push(context, MaterialPageRoute(builder: (context) => EmergencyContactsPage()));
              },
            ),
            SettingOption(
              text: 'Trauma Counselling', 
              icon: Icons.healing, 
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TraumaBookingPage()));
              }),
            SettingOption(text: 'Payments', 
            icon: Icons.payments, 
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentsPage()));
            }),
            SettingOption(text: 'Help and Support', icon: Icons.help, onTap: () {}),

            SettingOption(text: 'Log out', 
            icon: Icons.logout,
             onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:  (context) => LoginScreen()));
             }),
          ],
        ),
      ),
    );
  }
}

class SettingOption extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const SettingOption({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0), // Add bottom padding
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: const Color.fromARGB(75, 158, 158, 158)), // Add grey border at the bottom
          ),
        ),
        child: ListTile(
          leading: Icon(icon), // Add relevant icon
          title: Text(text),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey), // Grey trailing arrow
          onTap: onTap, // Call onTap function when tapped
        ),
      ),
    );
  }
}
