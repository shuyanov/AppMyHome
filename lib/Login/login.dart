// import 'package:flutter/material.dart';
// import 'package:hackaton/screens/HomePage.dart';
// import 'package:hackaton/screens/LoginPage.dart';
// import 'package:hackaton/screens/RegisterPage.dart';
// import 'dart:io';
// import 'dart:convert';
// import 'package:path_provider/path_provider.dart' as pathProvider;
// import 'package:hackaton/User.dart';

// class Var extends StatelessWidget {
//   bool goToHomePage = false;
//   String name = "";

//   Future<bool> ReadJsonFileFuture() async {
//     final directory = await pathProvider.getApplicationSupportDirectory();
//     final fileDirectory = directory.path + '/data.json';
//     final file = File(fileDirectory);
//     print("reading... $fileDirectory");

//     final isExist = await file.exists();
//     print("file found: $isExist");

//     if (!isExist) {
//       print("file not found, creating...");
//       await file.writeAsString(
//           '{ \"user\": { \"login\" : \"n\"\,\"password\" : \"\",\"surname\" : \"\",\"name\" : \"\",\"middle_name\" : \"\",\"code\" : \"\" } }',
//           flush: true);
//       await new Future.delayed(const Duration(seconds: 1));
//       return false;
//     } else {
//       getUser(); // verification func
//       if (name == "") {
//         print("name is empty");
//         await new Future.delayed(const Duration(seconds: 1));
//         return false;
//       } else {
//         print("go to Home Page ...");
//         await new Future.delayed(const Duration(seconds: 1));
//         return true;
// //go to dataBase func
//       }
//     }
//   }

//   void PushToJson(String login, String password, String surname, String name,
//       String middle_name, String code) async {
//     final directory = await pathProvider.getApplicationSupportDirectory();
//     final fileDirectory = directory.path + '/data.json';
//     final file = File(fileDirectory);
//     final isExists = await file.exists();

//     if (!isExists) {
//       print("pushing, file not found!");
//       return;
//     }

//     await file.writeAsString(
//         '\"user\": {\"login\" : \"$login\"\,\"password\" : \"$password\",\"surname\" : \"$surname\",\"name\" : \"$name\",\"middle_name\" : \"$middle_name\",\"code\" : \"$code\"}');

//     await new Future.delayed(const Duration(seconds: 1));
//   }

//   void getUser() async {
//     final directory = await pathProvider.getApplicationSupportDirectory();
//     final fileDirectory = directory.path + '/data.json';
//     final file = File(fileDirectory);

//     final json = jsonDecode(await file.readAsString());

//     print(json);
//     User nikita = User.fromJson(json['user']);
//     name = nikita.login;
//     print("login = ${nikita.login}");
//     await new Future.delayed(const Duration(seconds: 1));
//   }

//   Future ReadJsonFile() async {
//     final directory = await pathProvider.getApplicationSupportDirectory();
//     final fileDirectory = directory.path + '/data.json';
//     final file = File(fileDirectory);
//     print("reading... $fileDirectory");

//     final isExist = await file.exists();
//     print("file found: $isExist");

//     if (!isExist) {
//       print("file not found, creating...");
//       await file.writeAsString(
//           '{ \"user\": { \"login\" : \"n\"\,\"password\" : \"\",\"surname\" : \"\",\"name\" : \"\",\"middle_name\" : \"\",\"code\" : \"\" } }',
//           flush: true);
//       await new Future.delayed(const Duration(seconds: 1));
//       goToHomePage = false;
//       return;
//     } else {
//       getUser(); // verification func
//       if (name == "") {
//         print("name is empty");
//         await new Future.delayed(const Duration(seconds: 1));
//         goToHomePage = false;
//         return;
//       } else {
//         print("go to Home Page ...");
//         await new Future.delayed(const Duration(seconds: 1));
//         goToHomePage = true;
//         return;
// //go to dataBase func
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("Hello!");
//     ReadJsonFile();
//     print("end result = $goToHomePage");

//     return goToHomePage ? HomePage() : LoginPage();
//   }
// }
