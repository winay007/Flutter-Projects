import 'package:chat_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../screens/auth_screen.dart';
import './screens/chat_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatRoom',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          backgroundColor: Colors.pink,
          accentColor: Colors.deepPurple,
          accentColorBrightness: Brightness.dark,
          buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.pink,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                   )
                 )
        ),
      home: StreamBuilder(stream: FirebaseAuth.instance.onAuthStateChanged,builder: (ctx,usersnapshot){
        if(usersnapshot.connectionState ==  ConnectionState.waiting) {
          return SplashScreen();
        }
        if(usersnapshot.hasData){
          return ChatScreen();
        }
        return AuthScreen();
      },),
    );
  }
}
