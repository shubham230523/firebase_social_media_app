import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  // current logged in user
  User? user = FirebaseAuth.instance.currentUser;

  // get collection of posts from firebase
  final CollectionReference posts =
      FirebaseFirestore.instance.collection("Posts");

  // post a message
  Future<void> addPost(String message) {
    return posts.add({
      'UserEmail': user!.email,
      'PostMessage': message,
      'TimeStamp': Timestamp.now()
    });
  }

  // read posts from databases
  Stream<QuerySnapshot> getPostsStream() {
    final postStream = FirebaseFirestore.instance
        .collection('Posts')
        .orderBy('TimeStamp', descending: true)
        .snapshots();
    return postStream;
  }
  
}
