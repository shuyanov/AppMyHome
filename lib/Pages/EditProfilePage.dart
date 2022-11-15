import 'dart:async';
import 'dart:io';
import 'package:command_flutter/HomePage.dart';
import 'package:command_flutter/Model/User.dart';
import 'package:command_flutter/Utils/UserPerefer.dart';
import 'package:command_flutter/Widget/ButtonWidget.dart';
import 'package:editable_image/editable_image.dart';
import 'package:flutter/material.dart';



class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _profilePicFile;
  User user = UserPereferences.myUser;

  @override
  void initState() {
    super.initState();
  }

  void _directUpdateImage(File? file) async {
    if (file == null) return;
    setState(() {
      _profilePicFile = file;
    });
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
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Color.fromARGB(255, 124, 97, 242),
    ),
    body:
      Stack(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.all(0),
              child: Image.asset('assets/profile/profileBackground.jpg',width: 1000, fit:BoxFit.fill),
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
                    // ProfileWidget(
                    // imagePatch: user.imagePath,
                    // isEdit: true,
                    // onCliced: () async{},
                    // ),
                      const Spacer(flex: 2),
                      EditableImage(
                        // Define the method that will run on the change process of the image.
                        onChange: (file) => _directUpdateImage(file),
                        // Define the source of the image.
                        image: _profilePicFile != null
                            ? Image.file(_profilePicFile!, fit: BoxFit.cover)
                            : null,
                        // Define the size of EditableImage.
                        size: 150.0,

                        // Define the Theme of image picker.
                        imagePickerTheme: ThemeData(
                          // Define the default brightness and colors.
                          primaryColor: Colors.white,
                          shadowColor: Colors.transparent,
                          backgroundColor: Colors.yellowAccent,
                          iconTheme: const IconThemeData(color: Colors.yellowAccent),

                          // Define the default font family.
                          fontFamily: 'Georgia',
                        ),

                        // Define the border of the image if needed.
                        imageBorder: Border.all(color: Colors.black, width: 2.0),
                        // Define the border of the icon if needed.
                        editIconBorder: Border.all(color: Colors.black, width: 2.0),
                      ),
                      const Spacer(flex: 2),
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
                      const Spacer(),
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
                      const Spacer(),
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
                      const Spacer(),
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
                      const Spacer(flex: 3),
                      Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                  height: 50,
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

Widget buildEditProfileButton() => ButtonWidget(
  text:'Save',
  onClicked: (){
    Timer(Duration(seconds: 1), () {
      PushToJson(email, password, name, surName, middleName, "no");
      });
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => (HomePage()))
    );
    _LoginButtonActio();
    },
  );
}

