import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:command_flutter/Chats/Data/Admin.dart';
import 'package:command_flutter/Chats/api/firebase.dart';
import 'package:command_flutter/HomePage.dart';
import 'package:command_flutter/Pages/addImage.dart';
import 'package:command_flutter/Utils/UserPerefer.dart';
import 'package:command_flutter/Widget/ButtonWidget.dart';
import 'package:editable_image/editable_image.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  File? _profilePicFile;
  File? _SAVEprofilePicFile;

  @override
  void initState() {
    super.initState();
  }

  void _directUpdateImage(File? file) async {
    if (file == null) return;
    setState(() {
      _profilePicFile = file;
      addImage(_profilePicFile!);

      _SAVEprofilePicFile = _profilePicFile;
      Image.network(myUrlAvatar);
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

  Widget _FrontButton(){
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
                          SizedBox(height: 50),
                          EditableImage(
                            // Define the method that will run on the change process of the image.
                            onChange: (file) => _directUpdateImage(file),
                            // Define the source of the image.
                            image: _profilePicFile != null
                                ? Image.file( _profilePicFile!,  fit: BoxFit.cover)
                                : Image.network( myUrlAvatar!,  fit: BoxFit.cover),

                            // Define the size of EditableImage.
                            size: 150.0,

                            // Define the Theme of image picker.
                            imagePickerTheme: ThemeData(
                              // Define the default brightness and colors.
                              primaryColor: Colors.white,
                              shadowColor: Colors.transparent,
                              backgroundColor: Colors.white70,
                              iconTheme: const IconThemeData(color: Colors.black87),

                              // Define the default font family.
                              fontFamily: 'Georgia',
                            ),
                            // Define the border of the image if needed.
                            imageBorder: Border.all(color: Colors.black87, width: 2.0),

                            // Define the border of the icon if needed.
                            editIconBorder: Border.all(color: Colors.black87, width: 2.0),
                          ),
                          SizedBox(height: 30),
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
                          SizedBox(height: 30),
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
                          SizedBox(height: 30),
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
                          SizedBox(height: 30),
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
                          SizedBox(height: 40),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                            height: 40,
                            width: 320,
                            child: buildEditProfileButton()
                              ),
                            ),
                        ],
                      ),
        ),
                  ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       home: Scaffold(
            body: Stack(
              children: [
                Container(
                  child: Container(
                    child: Stack(
                      children: [
                        Image.asset('assets/profile/profileBackground.jpg',width: 1000, fit:BoxFit.fill),
                        Image.asset('assets/profile/GroundUpBar.png',width: 1000, fit:BoxFit.fill),
                      ],
                    ),
                  ),
                ),
                _FrontButton(),
              ],
            )
        )
    );
  }

  Widget buildEditProfileButton() =>
      ButtonWidget(
        text: 'Save',
        onClicked: () async {
          await addImage(_SAVEprofilePicFile!);
          Timer(Duration(seconds: 1), () {
            PushToJson(email, password, name, surName, middleName, "no");
            //Обновление данных для чата
            baseAPI.updateUser(userEmail: email, userSurname: surName, userName: name, userMiddle_name: middleName);
          });
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => (HomePage()))
          );
          _LoginButtonActio();
        },
      );

  funcPress() {
    void getUserTesta() async {

      final directory = await pathProvider.getApplicationSupportDirectory();
      final fileDirectory = directory.path + '/datasTest.json';
      final file = File(fileDirectory);
      final json = jsonDecode(await file.readAsString());

      print(json);
      UsersedTest nikita = UsersedTest.fromJson(json['user']);

      Timer(Duration(milliseconds: 50), () {
        nikita.numberPhone;
        nikita.surname;
        nikita.middle_name;
        nikita.name;
        print("User Data $name , and  $surName");
      });
    }
    getUserTesta();
  }
}

