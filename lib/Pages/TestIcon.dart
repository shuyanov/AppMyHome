// Copyright 2021 The EditableImage Author. All rights reserved.
// Use of this source code is governed by a Apache 2.0-style license
// that can be found in the LICENSE file.

import 'dart:io';

import 'package:command_flutter/Chats/Data/Admin.dart';
import 'package:command_flutter/Chats/api/firebase.dart';
import 'package:command_flutter/HomePage.dart';
import 'package:command_flutter/Pages/ProfilePage.dart';
import 'package:command_flutter/Pages/addImage.dart';
import 'package:editable_image/editable_image.dart';
import 'package:flutter/material.dart';

class HomeViewTest extends StatefulWidget {
  const HomeViewTest({Key? key}) : super(key: key);

  @override
  _HomeViewTestState createState() => _HomeViewTestState();
}

class _HomeViewTestState extends State<HomeViewTest> {
  File? _profilePicFile;
  File? _SAVEprofilePicFile;

  @override
  void initState() {
    super.initState();
  }

  // A simple usage of EditableImage.
  // This method gets called when trying to change an image.
  void _directUpdateImage(File? file) async {
    if (file == null) return;
    setState(() {
      _profilePicFile = file;
      //addImage(_profilePicFile!);

      _SAVEprofilePicFile = _profilePicFile;
      Image.network(myUrlAvatar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Profile Settings',
                style: TextStyle(
                  fontSize: 28.0,
                ),
              ),
              const Spacer(flex: 2),
              EditableImage(
                // Define the method that will run on the change process of the image.
                onChange: (file) => _directUpdateImage(file),
                // Define the source of the image.
                image: _profilePicFile != null
                    ? Image.file(_profilePicFile!, fit: BoxFit.cover)
                    : Image.network(myUrlAvatar, fit: BoxFit.cover),

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
              const Spacer(flex: 2),
              // _Open(),
              // Image(image: FileImage(_SAVEprofilePicFile!)),
              const Spacer(flex: 1),
              _buildTextButton(),
            ],
          ),
        ),
      ),
    );
  }

  TextButton _buildTextButton() {
    return TextButton(
      onPressed: () async {
        if(_SAVEprofilePicFile! != ''){
          await addImage(_SAVEprofilePicFile!);
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => (HomePage()))
          );
        }else{
          Navigator.pop(context);
        }
        },
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 20.0),
        ),
        side:
        MaterialStateProperty.all(const BorderSide(color: Colors.black54)),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
      ),
      child: const Text(
        'Save',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
