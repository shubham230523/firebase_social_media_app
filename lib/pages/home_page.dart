import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_social_media_app/components/my_drawer.dart';
import 'package:firebase_social_media_app/components/my_list_tile.dart';
import 'package:firebase_social_media_app/components/my_post_button.dart';
import 'package:firebase_social_media_app/components/my_textfield.dart';
import 'package:firebase_social_media_app/database/firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final FirestoreDatabase firestoreDatabase = FirestoreDatabase();
  final TextEditingController newPostController = TextEditingController();

  //post message
  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      firestoreDatabase.addPost(newPostController.text);
    }

    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("W A L L"),
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          // text field for user to type
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                // text field
                Expanded(
                  child: MyTextfield(
                      hintText: "Say something...",
                      obscureText: false,
                      controller: newPostController),
                ),

                // post button
                MyPostButton(onTap: () {})
              ],
            ),
          ),

          //posts
          StreamBuilder(
              stream: firestoreDatabase.getPostsStream(),
              builder: (context, snapshot) {
                // show loading circle
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // get all posts
                final posts = snapshot.data!.docs;
                if (snapshot.data == null || posts.isEmpty) {
                  return const Center(
                      child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text("No posts. Post something!"),
                  ));
                }

                // no data

                // return as a list
                return Expanded(
                    child: ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];

                          String message = post['PostMessage'];
                          String userEmail = post['UserEmail'];
                          Timestamp timestamp = post['TimeStamp'];

                          return MyListTile(
                              message: message, userEmail: userEmail);
                        }));
              })
        ],
      ),
    );
  }
}
