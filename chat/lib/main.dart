import 'package:chat/firebase_options.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:chat/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 플러터에서 파이어베이스를 사용하려면 메인메서드 내에서 비동기방식으로 반드시 이 메서드를 먼저 불러오고
  // Firebase.initializeApp()메서드를 불러와야한다.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Firebase.initializeApp()은 비동기 방식의 메서드
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatting app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        // stream을 전달해줌 => 새로운 value값 전달 // 로그인, 로그아웃 마다 authenticationState가 바뀌며 firebase가 발행해준 토큰을 firebase가 관리
        builder: (context, snapshot){
          if(snapshot.hasData) { // 인증을 받은 토큰을 가지고 있다면
            return ChatScreen();
          }
          return LoginSignupScreen();
        },
      ),
    );
  }
}