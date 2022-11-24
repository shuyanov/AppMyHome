import 'dart:async';
import 'package:command_flutter/CallPages/CallPage.dart';
import 'package:command_flutter/HomePage.dart';
import 'package:command_flutter/Login/LOginPage.dart';
import 'package:command_flutter/Login/RegisterPage.dart';
import 'package:command_flutter/PushNotifications/api/notification.dart';
import 'package:command_flutter/SendInEmail.dart';
import 'package:command_flutter/TestLogin.dart';
import 'package:command_flutter/Utils/UserPerefer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Notific();
  //await base.addUsers(users);
    runApp(MyApp());
  //   runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.greenAccent.shade400
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}