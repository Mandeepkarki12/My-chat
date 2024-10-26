import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices {
  // get instance of Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get users stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // go through each individual user
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  // send message

  // get message
}
