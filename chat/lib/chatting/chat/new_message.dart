import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _userEnterMessage = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLines: null, // 줄바꿈기능
              controller: _controller,
              decoration: InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                setState(() {
                  _userEnterMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _userEnterMessage.trim().isEmpty ? null : _sendMessage, // _userEnterMessage의 양쪽 공백을 제거했을 때 null값이면 send 버튼 활성화 x
            icon: Icon(Icons.send),
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    FocusScope.of(context).unfocus(); // 텍스트필드에 unfocused
    final user = FirebaseAuth.instance.currentUser; // userid와 같은 정보를 포함하고 있음
    final userData = await FirebaseFirestore.instance.collection('user').doc(user!.uid).get();
    FirebaseFirestore.instance.collection('chat').add({
      'text' : _userEnterMessage,
      'time' : Timestamp.now(), // 메세지 다큐먼트가 새롭게 저장될때마다 타임스탬프는 그 일부로서 함께 저장
      'userID' : user!.uid,// 메세지가 전달될 때 새롭게 전달될 userid, 내가 보낸 메세지인지 상대가 보낸 메세지인지 구분
      'userName' : userData.data()!['userName'],
      'userImage' : userData['picked_image']
    });
    _controller.clear();  // 메세지를 전송하면 메세지 입력 필드에서 삭제
  }
}
