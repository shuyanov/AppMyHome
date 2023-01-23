import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:command_flutter/HomePage.dart';
import 'package:command_flutter/ProfileCom/personalPage.dart';
import 'package:command_flutter/PushNotifications/api/notification.dart';
import 'package:command_flutter/Utils/UserPerefer.dart';
import 'package:command_flutter/loadingPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Chats/Data/Admin.dart';
import 'Styles/Themes.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   Notific();
//   //await base.addUsers(users);

//   // runApp(LoadingPage());
//   // runApp(MyApp());
// }

class MyAppTest extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, child) {
          return MaterialApp(
            themeMode: Provider.of<ThemeProvider>(context).themeMode,
            theme: Themes.light,
            darkTheme: Themes.dark,
            // home: HomePage(),
            home: personalPage(),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
