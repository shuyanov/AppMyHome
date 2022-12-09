import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:command_flutter/Pages/Widget/ProfileCircleImage.dart';
import 'package:command_flutter/Utils/UserPerefer.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:command_flutter/Chats/Data/Admin.dart';
import 'package:command_flutter/Chats/api/firebase.dart';

class WidgetProfileName extends StatefulWidget {
  const WidgetProfileName({Key? key}) : super(key: key);

  @override
  State<WidgetProfileName> createState() => _WidgetProfileNameState();
}

class _WidgetProfileNameState extends State<WidgetProfileName> {
  String name = "";
  String surName = "";

  String userImage = "";

  @override
  void initState() {
    funcPress();
    _GetDataFromJson();
    super.initState();
    baseAPI.readAvatar();
    print(name);
  }

  void _GetDataFromJson() async {
    final directory = await pathProvider.getApplicationSupportDirectory();
    final fileDirectory = directory.path + '/datas.json';
    final file = File(fileDirectory);
    final json = jsonDecode(await file.readAsString());

    var UsersedTest = new Usersed.fromJson(json['user']);

    name = UsersedTest.name;
    surName = UsersedTest.surname;

    setState(() {});
    text:'Edit';
    print(name);
    baseAPI.readAvatar();
  }

  @override
  Widget build(BuildContext context) {
    funcPress();
    return Padding(padding: const EdgeInsets.all(30),
        child: Align(
          alignment: Alignment.topLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      ProfileWidget(imagePath: "https://cdn-icons-png.flaticon.com/512/1946/1946429.png"),
                      ProfileWidget(imagePath: myUrlAvatar),
                    ],
                  )
              ),
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Text(name, style: TextStyle(fontSize: 36)),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(top: 45, left: 20),
                      child: Text(surName,
                        style: TextStyle(fontSize: 30, color: Colors.grey),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }

  funcPress() {
    void getUserTesta() async {
      final directory = await pathProvider.getApplicationSupportDirectory();
      final fileDirectory = directory.path + '/datasTest.json';
      final file = File(fileDirectory);
      final json = jsonDecode(await file.readAsString());

      print(json);
      UsersedTest nikita = UsersedTest.fromJson(json['user']);
      print("TEST 1 User Data $name , and  $surName");
      Timer(Duration(milliseconds: 50), () {
        name = nikita.name;
        surName = nikita.surname;
        print("TEST 2 User Data $name , and  $surName");
      });
    }
    getUserTesta();
  }
}
