import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('time', descending: true)
          .snapshots(), // 새로 전송하는 메세지가 하단에 쌓이도록
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = snapshot.data!.docs;
        return ListView.builder(
          reverse: true, // 메세지의 위치가 하단에서부터 시작
          itemCount: chatDocs.length,
          itemBuilder: (context, index) {
            return ChatBubbles(
              chatDocs[index]['text'],
              chatDocs[index]['userID'].toString() == user!.uid,
              chatDocs[index]['userName'],
              chatDocs[index]['userImage']
            );
          },
        );
      },
    );
  }
}

