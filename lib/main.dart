import 'dart:async';

import 'package:command_flutter/HomePage.dart';
import 'package:command_flutter/PushNotifications/api/notification.dart';
import 'package:command_flutter/SendInEmail.dart';
import 'package:command_flutter/Utils/UserPerefer.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Notific();
  //await base.addUsers(users);

 // runApp(MyApp());
    runApp(Send());
}
// void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///
     PushToJsonTest("maks_shuyanov@mail.ru", "password1", "surname1", "name1", "middle_name1", "code1", "id1", "stateAdmin1", "personalCheck1", "8890000");
     ViewJsonTest();

     Timer(Duration(seconds: 1), () {
       getUserTest();
       runApp(Send());
     });

    ///

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.greenAccent.shade400
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}