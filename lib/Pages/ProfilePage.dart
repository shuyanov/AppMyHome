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
    void GetDataFromJson() async{
      final directory = await pathProvider.getApplicationSupportDirectory();
      final fileDirectory = directory.path + '/datas.json';
      final file = File(fileDirectory);

      final json = jsonDecode(await file.readAsString());

      var UserActual = new Usersed.fromJson(json['user']);

      name = UserActual.login;
      surName = UserActual.surname;
    }

    GetDataFromJson();
    super.initState();
  }

  void r (){}
  @override
  Widget build(BuildContext context) {
   r();
    final user = UserPereferences.myUser;

    Timer(Duration(seconds: 3), () {
      print("3 Seconds");
      print(name);
      print(surName);
    });

    return Scaffold(
      backgroundColor: Color.fromARGB( 200, 105, 193, 238),
      //appBar: buildAppBar(context),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePatch: user.imagePath,
                onCliced: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EditProfilePage())
                  );
                },
              ),
              const SizedBox(height: 12),
              buildName(user),
              const SizedBox(height: 12),
              const SizedBox(height: 330),
              Expanded(
                child: Align(
                    alignment: Alignment(1, 1),
                    child: buildExitProfileButton()),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/ful.png'),
                fit: BoxFit.cover
            )
        ),
      ),
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






