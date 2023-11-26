import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'dart:io';
import 'dart:convert';
import 'Chats/Data/users.dart';
import 'Login/LOginPage.dart';
import 'Utils/UserPerefer.dart';
import 'main.dart';

class LoadingPage extends StatelessWidget {
  bool isLogged = false;
///////////////
  void getUser() async {
    final directory = await pathProvider.getApplicationSupportDirectory();
    final fileDirectory = directory.path + '/datasTest.json';
    final file = File(fileDirectory);
    final isExist = await file.exists();
    print("file found: $isExist");
    if (!isExist) {
      isLogged = false;
    } else {
      final json = jsonDecode(await file.readAsString());
      UsersedTest user = UsersedTest.fromJson(json['user']);
      print("code = ${user.name}");

      if (user.name != "") {
        isLogged = true;
        // addUser(
        //     "${user.id}",
        //     "${user.login}",
        //     "${user.surname}",
        //     "${user.name}",
        //     "${user.middle_name}",
        //     "${user.code}",
        //     "${user.stateAdmin}",
        //     "${user.personalCheck}",
        //     "${user.numberPhone}");
      }
    }
  }

///////////////
  @override
  Widget build(BuildContext context) {
    getUser();
    Timer(Duration(seconds: 1), () {
      print("Yeah, this line is printed after 3 seconds");
      if (isLogged) getUsers();
      return isLogged ? runApp(MyApp()) : runApp(LoginPage());
    });
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
          child: Scaffold(
            backgroundColor: Color.fromARGB(255, 103, 70, 150),
            body: Center(
              child: Text("Loading...", style: TextStyle(color: Colors.white)),
            ),
          ),
          //Text("Loadind, please wait..."),
        ));
  }
}
