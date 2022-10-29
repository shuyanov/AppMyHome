import 'package:command_flutter/Model/User.dart';
import 'package:command_flutter/Pages/ProfilePage.dart';
import 'package:command_flutter/Utils/UserPerefer.dart';
import 'package:command_flutter/Widget/Bar/AppBar.dart';
import 'package:command_flutter/Widget/TextFiel.dart';
import 'package:flutter/material.dart';

import '../Widget/ProfileWidget.dart';


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User user = UserPereferences.myUser;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
        ProfileWidget(
        imagePatch: user.imagePath,
        isEdit: true,
        onCliced: () async{},
        ),
          const SizedBox(height: 24),
          TextFieldWidget(
            lable: "FullName",
            text: user.name,
            onChanged: (name) {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            lable: "Email",
            text: user.email,
            onChanged: (email) {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            lable: "Phone Number",
            text: user.numberPhone,
            onChanged: (numberPhone) {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            lable: "About",
            text: user.about,
            onChanged: (about) {},
          )

        ],
      ),
    ),
  );
}
