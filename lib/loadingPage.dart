import 'dart:async';
import 'package:command_flutter/HomePage.dart';
import 'package:command_flutter/Login/LOginPage.dart';
import 'package:command_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'Utils/UserPerefer.dart';



class LoadingPage extends StatelessWidget {
  bool isLogged = false;
///////////////
  void getUser() async {

    final directory = await pathProvider.getApplicationSupportDirectory();
    final fileDirectory = directory.path + '/datasTest.json';
    final file = File(fileDirectory);
    final isExist = await file.exists();
    print("file found: $isExist");
    if(!isExist){
      isLogged = false;
    }
    else {
      final json = jsonDecode(await file.readAsString());
      UsersedTest user = UsersedTest.fromJson(json['user']);
      print("code = ${user.name}");
      if(user.name!=""){
        isLogged = true;
      }

    }

  }


///////////////
  @override
  Widget build(BuildContext context) {
    getUser();
    Timer(Duration(seconds: 1), () {

      print("Yeah, this line is printed after 3 seconds");
      return isLogged ? runApp(MyApp()) : runApp(LoginPage());
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Container(
          child: Scaffold(
            backgroundColor: Colors.purple,
            body: Center(
              child: Text( "Loading...", style: TextStyle(color: Colors.white)),
            ),

          ),
          //Text("Loadind, please wait..."),
        )
    );
  }
}
