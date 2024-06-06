import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
           const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Perform save changes logic 
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple, // Set button color to purple
              padding: EdgeInsets.symmetric(vertical: 16.0), // Adjust padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0), // Add border radius
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Save Changes',
                style: TextStyle(color: Colors.white, fontSize: 16.0), // Set text color to white and adjust font size
              ),
            ),
          ),
        ),

          ],
        ),
      ),
    );
  }

  void _saveChanges() {
    String name = _nameController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;
    String password = _passwordController.text;

    // Perform validation if needed

    // Perform save operation or send data to backend
    // For now, let's just print the values
    print('Name: $name');
    print('Email: $email');
    print('Phone: $phone');
    print('Password: $password');

    // Optionally, you can show a success message or navigate to another page
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
