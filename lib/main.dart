import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'Data/usersData.dart';
import 'HomePage.dart';
import 'PushNotifications/api/notification.dart';
import 'mainTest.dart';

 Future<void> initializeDefaultFromAndroidResource() async {
    if (defaultTargetPlatform != TargetPlatform.android || kIsWeb) {
      print('Not running on Android, skipping');
      return;
    }
    FirebaseApp app = await Firebase.initializeApp();
    print('Initialized default app $app from Android resource');
  }

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
Future main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  initializeDefaultFromAndroidResource;
//   try {
//   await Firebase.initializeApp();
// } catch (e) {
//   print('Error initializing Firebase: $e');
// }
         HttpOverrides.global = MyHttpOverrides();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Notific();
  //await base.addUsers(users);

    // runApp(LoadingPage());
    runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(user: users[0],),
      debugShowCheckedModeBanner: false,
    );
  }
}