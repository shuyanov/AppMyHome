import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:command_flutter/LoginPage.dart';
import 'package:command_flutter/Model/User.dart';
import 'package:command_flutter/Pages/EditProfilePage.dart';
import 'package:command_flutter/Utils/UserPerefer.dart';
import 'package:command_flutter/Widget/ButtonWidget.dart';
import 'package:command_flutter/Widget/ProfileWidget.dart';
import 'package:flutter/material.dart';

class ProfileePage extends StatefulWidget {
  const ProfileePage({Key? key}) : super(key: key);
  @override
  State<ProfileePage> createState() => _ProfileePageState();
}

class _ProfileePageState extends State<ProfileePage> {
  String name = "";
  String surName = "";

  @override
  void initState() {
    _GetDataFromJson();
    super.initState();
  }
  void _GetDataFromJson() async{
        final directory = await pathProvider.getApplicationSupportDirectory();
        final fileDirectory = directory.path + '/datas.json';
        final file = File(fileDirectory);

        final json = jsonDecode(await file.readAsString());

        var UserActual = new Usersed.fromJson(json['user']);

        name = UserActual.login;
        surName = UserActual.surname;
      }

  @override
  Widget build(BuildContext context) {
    final user = UserPereferences.myUser;

    // return Scaffold(
    //   body:
    //   Container(
    //     child: Padding(
    //       padding: const EdgeInsets.all(16),
    //       child:
    //       Row(
    //         children: [
    //           Expanded(
    //             flex: 3,
    //               child:
    //               ProfileWidget(
    //                 imagePatch: user.imagePath,
    //                 onCliced: () {
    //                   Navigator.of(context).push(
    //                       MaterialPageRoute(builder: (context) => EditProfilePage())
    //                   );
    //                 },
    //               ),),
    //           Expanded(child: buildName(user))
    //         ],
    //       )
    //       // child: ListView(
    //       //   physics: BouncingScrollPhysics(),
    //       //   children: [
    //       //     ProfileWidget(
    //       //       imagePatch: user.imagePath,
    //       //       onCliced: () {
    //       //         Navigator.of(context).push(
    //       //             MaterialPageRoute(builder: (context) => EditProfilePage())
    //       //         );
    //       //       },
    //       //     ),
    //       //     const SizedBox(height: 12),
    //       //     buildName(user),
    //       //     const SizedBox(height: 340),
    //       //     Expanded(// кнопка
    //       //       child: Align(
    //       //           alignment: Alignment(1, 1),
    //       //           child: buildExitProfileButton()),
    //       //     ),
    //       //   ],
    //       // ),
    //     ),
    //   ),
    // );
    return Padding( padding: const EdgeInsets.all(30),
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                flex: 1,
                child: ProfileWidget(
                  imagePatch: user.imagePath,
                  onCliced: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => EditProfilePage())
                      );
                    },
                ),
            ),
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Text(name, style: TextStyle(fontSize: 26)),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(top: 40, left: 20),
                      child: Text("SurName", style: TextStyle(fontSize: 16, color: Colors.grey),),
                    ),
                  ],
                ),
            ),

          ],
        ),
      )
    );
  }

  buildName(User user) => Column(
      children: [
        Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
        ),
        Text(
          surName,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );

  Widget buildExitProfileButton() => ButtonWidget(
    text:'Exit',
    onClicked: (){
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => LoginPage())
        );
      },
    );
  }






