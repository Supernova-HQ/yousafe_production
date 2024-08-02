import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yousafe/services/AuthService.dart';
import 'package:yousafe/services/ContactService.dart';
import 'package:yousafe/services/WhatsAppService.dart';
import 'package:whatsapp/whatsapp.dart';


class SOSRequestWidget extends StatefulWidget {
  @override
  _SOSRequestWidgetState createState() => _SOSRequestWidgetState();
}

class _SOSRequestWidgetState extends State<SOSRequestWidget> {
  String _status = 'Initiating SOS...';
  bool _success = false;
  bool _isCancelled = false;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  final AuthService _authService = AuthService();
  late ContactService _contactService;
  // late WhatsAppService _whatsappService;

  @override
  void initState() {
    super.initState();
    _contactService = ContactService(_authService.userId ?? '');
    // _whatsappService = WhatsAppService(
    //   accessToken: '5d8f66ad8610d0a1523c96e7d73220a7-32063b53-648c-43e8-a14d-47add567696f',
    //   phoneNumberId: '380637661797975',
    // );
    _startSOSProcess();
  }

  Future<void> _startSOSProcess() async {
    if (_isCancelled) return;

    try {
      setState(() => _status = 'Fetching emergency contacts...');
      final contacts = await _contactService.getContacts().first;

      if (_isCancelled) return;
      setState(() => _status = 'Sending SOS messages...');

      await _sendEmergencyMessages(contacts);

      if (_isCancelled) return;
      setState(() {
        _status = 'SOS messages sent successfully';
        _success = true;
      });

      await Future.delayed(Duration(seconds: 4));
      if (!_isCancelled) Navigator.pop(context);
    } catch (error) {
      setState(() => _status = 'Error: ${error.toString()}');
    }
  }

  Future<void> _sendEmergencyMessages(List<UContact> contacts) async {
    final message = 'Emergency Tumisang Swabi is in emergency and needs your help immediately! Click the link below for location:';
    
    for (var contact in contacts) {
      if (_isCancelled) return;

      try {
         final whatsapp = WhatsApp(
           'EAAHkgxvbeywBO0JlzZCj5Odbr48nRZBSmOb53zWhU54mtwf8qbQXgXBa9onB8YKeZAqFvHY4wB96dfrbZCLZCUJvv7ojrzvSWz1NQd57e5zZAwQgBkhUgkJJgCuboDJdpwJA8sZA2ITbWoh7RVQkbhaDI2kSglJ7s4jJaYQob0FoNfcUi5jOW82ZBPLsi520u6QCDwZDZD', '380637661797975'
         );


        var res = await whatsapp.sendMessage(
          phoneNumber: contact.phoneNumber,
          text: message,
          previewUrl : true,
        );

        if (res.isSuccess()) {
          print('SOS sent to ${contact.name}: ${res.getMessageId()}');
          // when message sent
          //Return id of message
          debugPrint('Message ID: ${res.getMessageId()}');

          //Return number where message sent
          debugPrint('Message sent to: ${res.getPhoneNumber()}');

          //Return exact API Response Body
          debugPrint('API Response: ${res.getResponse().toString()}');
        } else {
          //when something went wrong
          //Will return HTTP CODE
          debugPrint('HTTP Code: ${res.getHttpCode()}');

          // Will return exact error from WhatsApp Cloud API
          debugPrint('API Error: ${res.getErrorMessage()}');

          // Will return HTTP Request error
          debugPrint('Request Error: ${res.getError()}');

          //Return exact API Response Body
          debugPrint('API Response: ${res.getResponse().toString()}');
        }
      } catch (e) {
        print('Error sending SOS to ${contact.name}: $e');
      }
    }
  }

  void _cancelSOSProcess() {
    setState(() => _isCancelled = true);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('SOS Request'),
          actions: [
            if (!_success)
              IconButton(
                icon: Icon(Icons.cancel),
                onPressed: _cancelSOSProcess,
              ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_success)
                Icon(Icons.check_circle_outline, color: Colors.green, size: 80)
              else
                Lottie.asset(
                  'assets/help_is_coming.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                  repeat: true,
                ),
              SizedBox(height: 16),
              if (!_success) CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(_status, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:yousafe/services/AuthService.dart';
// import 'package:yousafe/services/ContactService.dart';
// import 'package:yousafe/services/WhatsAppService.dart';


// class SOSRequestWidget extends StatefulWidget {
//   @override
//   _SOSRequestWidgetState createState() => _SOSRequestWidgetState();
// }

// class _SOSRequestWidgetState extends State<SOSRequestWidget> {
//   String _status = 'Calling for Help...';
//   bool _success = false;
//   bool _isCancelled = false;
//   final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
//   List<Map<String, dynamic>> emergencyContacts = [];
//   late ContactService _contactService;
//   final AuthService _authService = AuthService();
//     final whatsapp = WhatsAppService(
//     accessToken: 'YOUR_ACCESS_TOKEN',
//     phoneNumberId: 'YOUR_PHONE_NUMBER_ID',
//   );

//   @override
//   void initState() {
//     super.initState();
//      _contactService = ContactService(_authService.userId ?? '');
//     _fetchEmergencyContacts();
//     _startSOSProcess();
//   }

//   Future<void> _fetchEmergencyContacts() async {
//   final accessToken = await _secureStorage.read(key: 'access_token');
//   final url = Uri.parse('http://64.23.186.45/api/main/contacts');

//   try {
//     final response = await http.get(
//       url,
//       headers: {'Authorization': 'Bearer $accessToken'},
//     );

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> responseData = jsonDecode(response.body);
//       final List<dynamic> contactsData = responseData['contacts']; // Assuming the contacts are stored under the 'contacts' key
//       setState(() {
//         emergencyContacts = contactsData.map((contact) => Map<String, dynamic>.from(contact)).toList();
//       });
//     } else {
//       print('Failed to fetch emergency contacts. Status code: ${response.statusCode}');
//     }
//   } catch (error) {
//     print('Error fetching emergency contacts: $error');
//   }
// }
//   Future<void> _sendEmergencySMS() async {
//     final accessToken = await _secureStorage.read(key: 'access_token');
//     final url = Uri.parse('http://64.23.186.45/api/main/emergency/');

//     try {
//       final response = await http.post(
//         url,
//         headers: {'Authorization': 'Bearer $accessToken'},
//       );

//       if (response.statusCode == 200) {
//         print('Emergency SMS sent successfully');
//       } else {
//         print('Failed to send emergency SMS. Status code: ${response.statusCode}');
//       }
//     } catch (error) {
//       print('Error sending emergency SMS: $error');
//     }
//   }

//   Future<void> _startSOSProcess() async {
//     if (_isCancelled) return;

//     setState(() {
//       _status = 'Calling for help...';
//     });

//     await Future.delayed(Duration(seconds: 2));
//     if (_isCancelled) return;
//     setState(() {
//       _status = 'Reaching out to your emergency contacts';
//     });

//     final contacts = await _contactService.getContacts().first;
//     if (_isCancelled) return;

//     setState(() {
//       _status = 'Sending your location to emergency contacts';
//     });

//     await _sendEmergencySMSFirebase(contacts);
//     if (_isCancelled) return;

//     await Future.delayed(Duration(seconds: 2));
//     if (_isCancelled) return;

//     setState(() {
//       _status = 'Your location has been sent out to all contacts';
//       _success = true;
//     });

//     await Future.delayed(Duration(seconds: 4));
//     if (_isCancelled) return;

//     Navigator.pop(context);
//   }

//    Future<void> _sendEmergencySMSFirebase(List<UContact> contacts) async {
//     final message = 'SOS! I need immediate assistance.';
//     for (var contact in contacts) {
//       if (_isCancelled) return;

//       var res = await whatsapp.sendMessage(
//         phoneNumber: contact.phoneNumber,
//         text: message,
//       );

//       if (res.isSuccess()) {
//         print('Message sent to ${contact.name}: ${res.getMessageId()}');
//       } else {
//         print('Failed to send message to ${contact.name}');
//         print('HTTP: ${res.getHttpCode()}');
//         print('API Error: ${res.getErrorMessage()}');
//       }
//     }
//   }

//   void _cancelSOSProcess() {
//     setState(() {
//       _isCancelled = true;
//     });
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false, // Prevent the screen from being popped by the user
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('SOS Request'),
//           actions: [
//             if (!_success)
//               IconButton(
//                 icon: Icon(Icons.cancel),
//                 onPressed: _cancelSOSProcess,
//               ),
//           ],
//         ),
//         body: Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               if (_success)
//                 Icon(
//                   Icons.check_circle_outline,
//                   color: Colors.green,
//                   size: 80,
//                 ),
//               if (!_success)
//                 Lottie.asset(
//                   'assets/help_is_coming.json',
//                   width: 200,
//                   height: 200,
//                   fit: BoxFit.contain,
//                   repeat: true,
//                 ),
//               SizedBox(height: 16),
//               if (!_success) CircularProgressIndicator(), // Show loading indicator
//               SizedBox(height: 16),
//               Text(_status), // Show status message
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }









// Future<void> _startSOSProcess() async {
  //   if (_isCancelled) return;

  //   // Simulate calling for help
  //   await Future.delayed(Duration(seconds: 2));
  //   if (_isCancelled) return;
  //   setState(() {
  //     _status = 'Reaching out to your emergency contacts';
  //   });

  //   // Simulate reaching out to emergency contacts
  //   await Future.delayed(Duration(seconds: 2));
  //   if (_isCancelled) return;
  //   setState(() {
  //     _status = 'Sending your location to emergency contacts';
  //   });

  //   // Send emergency SMS to contacts
  //   await _sendEmergencySMS();

  //   // Simulate sending location via SMS
  //   await Future.delayed(Duration(seconds: 2));
  //   if (_isCancelled) return;

  //   // After completing the SOS process, wait for 4 seconds before displaying success message
  //   await Future.delayed(Duration(seconds: 4));
  //   if (_isCancelled) return;
  //   setState(() {
  //     _status = 'Your location has been sent out to all contacts';
  //     _success = true;
  //   });

  //   // Wait for 4 seconds before exiting
  //   await Future.delayed(Duration(seconds: 4));
  //   if (_isCancelled) return;

  //   // Pop the screen after 4 seconds
  //   Navigator.pop(context);
  // }