import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:command_flutter/HomePage.dart';
import 'package:command_flutter/PushNotifications/api/notification.dart';
import 'package:command_flutter/Utils/UserPerefer.dart';
import 'package:command_flutter/loadingPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Chats/Data/Admin.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Notific();
  //await base.addUsers(users);

    runApp(LoadingPage());

}

class MyApp extends StatelessWidget {
  // @override
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