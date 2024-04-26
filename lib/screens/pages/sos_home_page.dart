import 'package:flutter/material.dart';
import 'package:yousafe/screens/pages/sos_request.dart';
import 'package:shake/shake.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_background/flutter_background.dart';

class SOSHomePage extends StatefulWidget {
  @override
  _SOSHomePageState createState() => _SOSHomePageState();
}

class _SOSHomePageState extends State<SOSHomePage> {
  @override
  void initState() {
    super.initState();
    _setupShakeDetector();
  }

  void _setupShakeDetector() async {
    final backgroundConfig = FlutterBackgroundAndroidConfig(
      notificationTitle: 'YouSafe',
      notificationText: 'Shake detection is running in the background',
      notificationImportance: AndroidNotificationImportance.Default,
      notificationIcon: AndroidResource(name: 'background_icon', defType: 'drawable'),
    );
    bool success = await FlutterBackground.initialize(androidConfig: backgroundConfig);
    if (success) {
      FlutterBackground.enableBackgroundExecution();
    }

    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        _vibrate();
        _showShakeDetectedSnackbar();
        _startSOSProcess();
      },
      minimumShakeCount: 3,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
    detector.startListening();
  }

  void _vibrate() async {
    bool? hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator ?? false) {
      Vibration.vibrate(duration: 500);
    }
  }

  void _showShakeDetectedSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Shake detected! Sending SOS...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _startSOSProcess({bool fromButton = false}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SOSRequestWidget()),
    );

    if (fromButton) {
      print('Sending SOS from button...');
    } else {
      print('Sending SOS from shake...');
    }
    // Implement sending SOS logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
          onPressed: () => _startSOSProcess(fromButton: true),
          style: ElevatedButton.styleFrom(
            primary: Colors.red[600],
            shape: CircleBorder(),
            padding: EdgeInsets.all(80),
          ),
          child: Text(
            'TAP TO\nSEND SOS',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}