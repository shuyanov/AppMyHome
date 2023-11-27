// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:my_home/Chats/api/firebase.dart';
// import 'package:path_provider/path_provider.dart' as pathProvider;

// import '../Chats/Data/Admin.dart';
// import '../Pages/Widget/ProfileCircleImage.dart';
// import '../Utils/UserPerefer.dart';

// class WidgetProfileName extends StatefulWidget {
//   final user;
//   const WidgetProfileName({required this.user});

//   @override
//   State<WidgetProfileName> createState() => _WidgetProfileNameState();
// }

// class _WidgetProfileNameState extends State<WidgetProfileName> {
//   String name = "";
//   String surName = "";

//   String userImage = "";

//   @override
//   void initState() {
//     name = widget.user.name;
//     userImage = widget.user.imagePath;
//     funcPress();
//     _GetDataFromJson();
//     super.initState();
//     imageURL();
//     print(name);
//   }

//   Future imageURL() async {
//     await baseAPI.readAvatar();
//   }

//   void _GetDataFromJson() async {
//     final directory = await pathProvider.getApplicationSupportDirectory();
//     final fileDirectory = directory.path + '/datas.json';
//     final file = File(fileDirectory);
//     final json = jsonDecode(await file.readAsString());

//     var UsersedTest = new Usersed.fromJson(json['user']);

//     name = UsersedTest.name;
//     surName = UsersedTest.surname;

//     setState(() {});    
//     print(name);
//     baseAPI.readAvatar();
//   }

//   @override
//   Widget build(BuildContext context) {
//     funcPress();

//     return Padding(padding: const EdgeInsets.all(30),
//         child: Align(
//           alignment: Alignment.topLeft,
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Expanded(
//                   flex: 1,
//                   child: Stack(
//                     children: [
//                       ProfileWidget(
//                               imagePath:
//                               "https://cdn-icons-png.flaticon.com/512/1946/1946429.png"),
//                       FutureBuilder(
//                           future: baseAPI.readAvatar(),
//                           builder: (context, snapshot) {
//                             if (snapshot.hasData) {
//                               final avatar = snapshot.data;
//                               return ProfileWidget(imagePath: avatar);
//                             } 
//                             return ProfileWidget(
//                               imagePath:
//                               "https://cdn-icons-png.flaticon.com/512/1946/1946429.png");
//                           })
//                     ],
//                   )),
//               Expanded(
//                 flex: 2,
//                 child: Stack(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(9.0),
//                       child: Text(myUserName, style: TextStyle(fontSize: 36)),
//                     ),
//                     const SizedBox(height: 20),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 45, left: 20),
//                       child: Text(
//                         myUserSurname,
//                         style: TextStyle(fontSize: 30, color: Colors.grey),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }

//   funcPress() {
//     void getUserTesta() async {
//       final directory = await pathProvider.getApplicationSupportDirectory();
//       final fileDirectory = directory.path + '/datasTest.json';
//       final file = File(fileDirectory);
//       final json = jsonDecode(await file.readAsString());

//       print(json);
//       UsersedTest nikita = UsersedTest.fromJson(json['user']);
//       print("TEST 1 User Data $name , and  $surName");
//       Timer(Duration(milliseconds: 50), () {
//         name = nikita.name;
//         surName = nikita.surname;
//         print("TEST 2 User Data $name , and  $surName");
//       });
//     }

//     getUserTesta();
//   }
// }

import 'package:flutter/material.dart';
import '/Model/User.dart';

class WidgetProfileName extends StatelessWidget {
  final User user;
  const WidgetProfileName({required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Align(
          alignment: Alignment.topLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              
                      CircleAvatar(
                        backgroundImage: NetworkImage("https://cdn-icons-png.flaticon.com/512/1946/1946429.png"),
                        foregroundImage: NetworkImage(user.imagePath),
                        radius: 50,
                      ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(user.name, style: TextStyle(fontSize: 30, color: Colors.white)),
                      ],
                    ),
                    
                    Text(user.about, style: TextStyle(fontSize: 16, color: Colors.white)),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 45, left: 20),
                    //   child: Text(
                    //     myUserSurname,
                    //     style: TextStyle(fontSize: 30, color: Colors.grey),
                    //   ),
                    // ),
                  ],
                
              ),
            ],
          ),
        ));
  }}