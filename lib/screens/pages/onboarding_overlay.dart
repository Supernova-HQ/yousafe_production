import 'package:flutter/material.dart';

class OnboardingOverlay extends StatefulWidget {
  final VoidCallback onFinished;

  OnboardingOverlay({required this.onFinished});

  @override
  _OnboardingOverlayState createState() => _OnboardingOverlayState();
}

class _OnboardingOverlayState extends State<OnboardingOverlay> {
  int _currentIndex = 0;
  final List<String> _messages = [
    'Instantly access help with a single tap using the SOS button for peace of mind in any situation',
    'Securely manage your emergency contacts with our safety app all in one place',
    'Easily share your live location with trusted contacts during emergencies or everyday situations with the personal safety apps live location sharing feature, ensuring you are never alone in times of need',
    'Customize your safety experience with the personal safety apps profile page, where you can manage settings, emergency contacts, and account details securely and conveniently.',
  ];

  void _nextMessage() {
    if (_currentIndex < _messages.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      widget.onFinished();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Stack(
        children: [
          Positioned(
            bottom: 100,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    _messages[_currentIndex],
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _nextMessage,
                    child: Text('Next'),
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