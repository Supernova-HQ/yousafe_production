import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildNotificationItem(
            icon: Icons.location_on,
            message: 'You have started sharing your live location',
          ),
          SizedBox(height: 16.0),
          _buildNotificationItem(
            icon: Icons.location_off,
            message: 'Live location ended',
          ),

           SizedBox(height: 16.0),
          _buildNotificationItem(
            icon: Icons.sos,
            message: 'Your call for help was sent to your 5 emergency contacts',
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({required IconData icon, required String message}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: const Color.fromARGB(48, 158, 158, 158), width: 1.0)),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(message),
      ),
    );
  }
}
