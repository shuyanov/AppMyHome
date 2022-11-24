import 'dart:async';
import 'dart:io';
import 'package:command_flutter/Chats/api/firebase.dart';
import 'package:command_flutter/HomePage.dart';
import 'package:command_flutter/Pages/TestPage.dart';
import 'package:command_flutter/Utils/UserPerefer.dart';
import 'package:command_flutter/Widget/ButtonWidget.dart';
import 'package:flutter/material.dart';


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  void initState() {
    super.initState();
  }


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController surNameController = TextEditingController();

  String email = '';
  String password = '';
  String name = '';
  String middleName = '';
  String surName = '';

  Future<void> _LoginButtonActio() async {
    email = emailController.text;
    password = passwordController.text;
    name = nameController.text;
    surName = surNameController.text;
    middleName = middleNameController.text;

    print("login: login = ${email} password = ${password}");
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    surNameController.clear();
    middleNameController.clear();
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 124, 97, 242),
          ),
          body:
          Stack(
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: Image.asset(
                      'assets/profile/profileBackground.jpg', width: 1000,
                      fit: BoxFit.fill),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child:
                  Stack(
                    children: <Widget>
                    [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 50),
                          HomeView(),
                          SizedBox(height: 70),
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                labelText: 'Email'
                            ),
                            onChanged: (name) {},
                          ),
                          SizedBox(height: 25),
                          TextField(
                            controller: surNameController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                labelText: 'Surname'
                            ),
                            onChanged: (name) {},
                          ),
                          SizedBox(height: 25),
                          TextField(
                            controller: middleNameController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                labelText: 'middleName'
                            ),
                            onChanged: (name) {},
                          ),
                          SizedBox(height: 25),
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                labelText: 'name'
                            ),
                            onChanged: (name) {},
                          ),
                          SizedBox(height: 25),
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                  height: 40,
                                  width: 320,
                                  child: buildEditProfileButton()
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
              ),
            ],
          )
      );
  Widget buildEditProfileButton() =>
      ButtonWidget(
        text: 'Save',
        onClicked: () {
          Timer(Duration(seconds: 1), () {
            PushToJson(email, password, name, surName, middleName, "no");
            //Обновление данных для чата
            base.updateUser(userEmail: email, userSurname: surName, userName: name, userMiddle_name: middleName);
          });
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => (HomePage()))
          );
          _LoginButtonActio();
        },
      );
}

