import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_chat/Models/message.dart';

class ChatServices {
  // get instance of Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
  Future<void> sendMessage(String recieverId, message) async {
    // get current user info
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
        currentUserId, currentUserEmail, recieverId, message, timestamp);

    // construct chat room id for the two users (sorted to ensure uniquenes)
    List<String> ids = [currentUserId, recieverId];
    ids.sort(); // it ensures the chatroomId is the same for any two people
    String chatroomId = ids.join('_');

    // add new message to database
    await _firestore
        .collection("chat_rooms")
        .doc(chatroomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // get message
  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    // construct a chatroom id for the two users
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false).snapshots();
  }
}
