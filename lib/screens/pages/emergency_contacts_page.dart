import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';

class EmergencyContactsPage extends StatefulWidget {
  @override
  _EmergencyContactsPageState createState() => _EmergencyContactsPageState();
}

class _EmergencyContactsPageState extends State<EmergencyContactsPage> {
  List<Map<String, dynamic>> emergencyContacts = [];
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    fetchEmergencyContacts();
  }

  Future<void> fetchEmergencyContacts() async {
    final accessToken = await storage.read(key: 'access_token');
    final url = 'http://64.23.186.45/api/main/contacts/';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final contacts = List<Map<String, dynamic>>.from(data['contacts']);
        setState(() {
          emergencyContacts = contacts;
        });
      } else {
        showSnackBar('Failed to fetch emergency contacts. Please try again.');
        print('Failed to fetch emergency contacts: ${response.body}');
      }
    } catch (error) {
      showSnackBar('Error fetching emergency contacts. Please try again later.');
      print('Error fetching emergency contacts: $error');
    }
  }

  Future<void> createEmergencyContact(String name, String mobileNo) async {
    final accessToken = await storage.read(key: 'access_token');
    final url = 'http://64.23.186.45/api/main/create-contact/';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'name': name, 'mobile_no': mobileNo}),
      );

      if (response.statusCode == 201) {
        showSnackBar('Emergency contact added successfully.', isError: false);
        await fetchEmergencyContacts();
      } else {
        showSnackBar('Failed to add emergency contact. Please try again.');
        print('Failed to add emergency contact: ${response.body}');
      }
    } catch (error) {
      showSnackBar('Error adding emergency contact. Please try again later.');
      print('Error adding emergency contact: $error');
    }
  }

  Future<void> _addContactFromPhonebook() async {
    if (await Permission.contacts.request().isGranted) {
      try {
        final Contact? contact = await ContactsService.openDeviceContactPicker();
        if (contact != null) {
          if (emergencyContacts.length < 5) {
            final name = contact.displayName ?? '';
            final mobileNo = contact.phones?.first.value ?? '';
            await createEmergencyContact(name, mobileNo);
          } else {
            showSnackBar('You can only add up to 5 contacts.');
          }
        }
      } catch (e) {
        showSnackBar('Error picking contact. Please try again.');
        print('Error picking contact: $e');
      }
    } else {
      showSnackBar('Contact permission not granted.');
    }
  }

  void _showDeleteConfirmationBottomSheet(int index) {
    final contact = emergencyContacts[index];
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Are you sure you want to delete "${contact['name']}"?',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Cancel'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final contactId = contact['id'];
                      final accessToken = await storage.read(key: 'access_token');
                      final url = 'http://64.23.186.45/api/main/delete-contact/$contactId/';

                      try {
                        final response = await http.delete(
                          Uri.parse(url),
                          headers: {
                            'Authorization': 'Bearer $accessToken',
                          },
                        );

                        if (response.statusCode == 204) {
                          showSnackBar('Contact deleted successfully.', isError: false);
                          await fetchEmergencyContacts();
                        } else {
                          showSnackBar('Failed to delete contact. Please try again.');
                          print('Failed to delete contact: ${response.body}');
                        }
                      } catch (error) {
                        showSnackBar('Error deleting contact. Please try again later.');
                        print('Error deleting contact: $error');
                      }

                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void showSnackBar(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Emergency Contacts'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          if (emergencyContacts.length < 5)
            IconButton(
              icon: const Icon(Icons.add, color: Colors.purple),
              color: Colors.purple,
              onPressed: _addContactFromPhonebook,
            ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/homepage');
            },
            child: const Text(
              'Skip for Now',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            const Text(
              'Add up to 5 contacts',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: emergencyContacts.length,
                itemBuilder: (context, index) {
                  final contact = emergencyContacts[index];
                  return ListTile(
                    tileColor: Colors.white,
                    title: Text(contact['name']),
                    subtitle: Text(contact['mobile_no']),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.grey),
                      onPressed: () {
                        _showDeleteConfirmationBottomSheet(index);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}