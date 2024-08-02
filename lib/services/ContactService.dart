import 'package:cloud_firestore/cloud_firestore.dart';

class ContactService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _userId;

  ContactService(this._userId);

  Future<void> addContact(String name, String phoneNumber) async {
  try {
    // Check if _userId is valid
    if (_userId == null || _userId.isEmpty) {
      throw ArgumentError('User ID must not be null or empty.');
    }

    // Ensure that name and phoneNumber are not empty
    if (name == null || name.isEmpty) {
      throw ArgumentError('Name must not be null or empty.');
    }
    if (phoneNumber == null || phoneNumber.isEmpty) {
      throw ArgumentError('Phone number must not be null or empty.');
    }

    // Attempt to add the contact
    await _firestore
        .collection('emergency_contacts')
        .doc(_userId)
        .collection('contacts')
        .add({
      'name': name,
      'phoneNumber': phoneNumber,
      'createdAt': FieldValue.serverTimestamp(),
    });

    print('Contact added successfully.');
  } catch (e) {
    print('Error adding contact to Firestore: $e');
    rethrow; // Rethrow if you want the error to propagate further
  }
}

  Stream<List<UContact>> getContacts() {
    return _firestore
        .collection('emergency_contacts')
        .doc(_userId)
        .collection('contacts')
        .orderBy('name')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return UContact(
          id: doc.id,
          name: doc['name'],
          phoneNumber: doc['phoneNumber'],
        );
      }).toList();
    });
  }
}

class UContact {
  final String id;
  final String name;
  final String phoneNumber;

  UContact({required this.id, required this.name, required this.phoneNumber});
}