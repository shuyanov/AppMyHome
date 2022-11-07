import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:command_flutter/Widget/WidgetProfile.dart';
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


    print(name);
    print(surName);
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

    Timer(Duration(seconds: 3), () {
      print("3 Seconds");
      print(name);
      print(surName);
    });

    return Column(
      children: [
        Container(
          child: WidgetProfileName()
        ),
        Padding(
            padding: EdgeInsets.only(left: 200),
            child: Container(
              height: 40,
              width: 160,
              child: buildEditProfileButton(),
            )
        ),
        SizedBox(height: 60),
        Padding(
            padding: EdgeInsets.only(left: 20,right: 20,bottom: 10 ),
            child: Container(
              height: 30,
              width: 330,
              child: buildPersonalBillButton(),
            )
        ),
        SizedBox(height: 10),
        Padding(
            padding: EdgeInsets.only(left: 20,right: 20,bottom: 10 ),
            child: Container(
              height: 30,
              width: 330,
              child: build_UK_Button(),
            )
        ),
        SizedBox(height: 10),
        Padding(
            padding: EdgeInsets.only(left: 20,right: 20,bottom: 10 ),
            child: Container(
              height: 30,
              width: 330,
              child: build_Problem_Button(),
            )
        ),
        SizedBox(height: 10),
        Padding(
            padding: EdgeInsets.only(left: 20,right: 20,bottom: 10 ),
            child: Container(
              height: 30,
              width: 330,
              child:  build_worker_Button(),
            )
        ),
        SizedBox(height: 100),
        Padding(
            padding: EdgeInsets.only(left: 20,right: 20,bottom: 10 ),
            child: Container(
              height: 30,
              width: 330,
              child: build_Setting_Button(),
            )
        ),
        SizedBox(height: 10),
        Padding(
            padding: EdgeInsets.only(left: 20,right: 20,bottom: 10 ),
            child: Container(
              height: 30,
              width: 330,
              child: buildExitProfileButton(),
            )
          )
        ],
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
    text:'Выход',
    onClicked: (){
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => LoginPage())
        );
      },
    );

  Widget buildEditProfileButton() => ButtonWidget(
    text:'Редактировать',
    onClicked: (){
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EditProfilePage())
      );
    },
  );

  Widget buildPersonalBillButton() => ButtonWidget(
    text:'Лицевой Счёт',
    onClicked: (){
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EditProfilePage())
      );
    },
  );

  Widget build_UK_Button() => ButtonWidget(
    text:'Обращение в УК',
    onClicked: (){
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EditProfilePage())
      );
    },
  );

  Widget build_Problem_Button() => ButtonWidget(
    text:'Сообщить о проблеме',
    onClicked: (){
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EditProfilePage())
      );
    },
  );

  Widget build_worker_Button() => ButtonWidget(
    text:'Обратиться к ремонтным служюам',
    onClicked: (){
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EditProfilePage())
      );
    },
  );

  Widget build_Setting_Button() => ButtonWidget(
    text:'Настройки',
    onClicked: (){
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EditProfilePage())
      );
    },
  );

  }






