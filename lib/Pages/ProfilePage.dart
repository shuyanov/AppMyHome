<<<<<<< Updated upstream
=======
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:command_flutter/LoginPage.dart';
>>>>>>> Stashed changes
import 'package:command_flutter/Model/User.dart';
import 'package:command_flutter/Utils/UserPerefer.dart';
import 'package:command_flutter/Widget/Bar/AppBar.dart';
import 'package:command_flutter/Widget/ButtonWidget.dart';
import 'package:command_flutter/Widget/ProfileWidget.dart';
import 'package:flutter/material.dart';

class ProfileePage extends StatefulWidget {
  const ProfileePage({Key? key}) : super(key: key);
  @override
  State<ProfileePage> createState() => _ProfileePageState();
}

class _ProfileePageState extends State<ProfileePage> {
<<<<<<< Updated upstream
  @override
  Widget build(BuildContext context) {
    final user = UserPereferences.myUser;

=======
  String name = "";
  String surName = "";

  void GetDataFromJson() async{
    final directory = await pathProvider.getApplicationSupportDirectory();
    final fileDirectory = directory.path + '/datas.json';
    final file = File(fileDirectory);

    final json = jsonDecode(await file.readAsString());

    var UserActual = new Usersed.fromJson(json['user']);
    name = UserActual.name;
    surName = UserActual.surname;
  }

  @override
  Widget build(BuildContext context) {
    final user = UserPereferences.myUser;
    GetDataFromJson();

    Timer(Duration(seconds: 3), () {
      return runApp(ProfileePage());
    });
    setState(() {

    });
>>>>>>> Stashed changes
    return Scaffold(
      //appBar: buildAppBar(context),
<<<<<<< Updated upstream
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePatch: user.imagePath,
              onCliced: () async{},
            ),
            const SizedBox(height: 12),
            buildName(user),
            const SizedBox(height: 24),
            Center( child: buildExitProfileButton()),
          ],
        ),
=======
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
>>>>>>> Stashed changes
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
    text:'Edit Profile',
    onClicked: (){},
    // {
    //   builder: (BuildContext){
    //     return Scaffold(
    //       appBar: AppBar(
    //         title: const Text('Test'),
    //         backgroundColor: Colors.blueAccent,
    //       ),
    //     );
    //   };
    // },
  );
  }
