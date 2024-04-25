import 'package:flutter/material.dart';
import 'package:yousafe/screens/pages/payments_page.dart';
import 'package:yousafe/screens/pages/trauma_booking.dart';
import 'edit_profile.dart';
import 'emergency_contacts_page.dart';
import 'package:yousafe/screens/auth/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
            const SizedBox(height: 20.0),
            const Text(
              'Account Settings',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15.0),
            SettingOption(
              text: 'Personal information',
              icon: Icons.person,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()));
              },
            ),
            SettingOption(
              text: 'Emergency Contacts',
              icon: Icons.emergency,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EmergencyContactsPage()));
              },
            ),
            SettingOption(
              text: 'Trauma Counselling',
              icon: Icons.healing,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TraumaBookingPage()));
              },
            ),
            SettingOption(
              text: 'Payments',
              icon: Icons.payments,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PaymentsPage()));
              },
            ),
            SettingOption(
              text: 'Help and Support',
              icon: Icons.help,
              onTap: () {},
            ),
            SettingOption(
              text: 'Log out',
              icon: Icons.logout,
              onTap: () {
                _logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _logout(BuildContext context) async {
  final storage = FlutterSecureStorage();
  final token = await storage.read(key: 'access_token');

  final response = await http.post(
    Uri.parse('https://supernova-fqn8.onrender.com/api/users/logout/'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    await storage.delete(key: 'access_token');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logout failed. Please try again.')),
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
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom:
                BorderSide(color: const Color.fromARGB(75, 158, 158, 158)),
          ),
        ),
        child: ListTile(
          leading: Icon(icon),
          title: Text(text),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
          onTap: onTap,
        ),
      ),
    );
  }
}