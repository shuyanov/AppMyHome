import 'package:command_flutter/Model/User.dart';
import 'package:command_flutter/Utils/UserPerefer.dart';
import 'package:command_flutter/Widget/Bar/AppBar.dart';
import 'package:command_flutter/Widget/ProfileWidget.dart';
import 'package:flutter/material.dart';

class ProfileePage extends StatefulWidget {
  const ProfileePage({Key? key}) : super(key: key);

  @override
  State<ProfileePage> createState() => _ProfileePageState();
}

class _ProfileePageState extends State<ProfileePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserPereferences.myUser;

    return Scaffold(
      //appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePatch: user.imagePath,
            onCliced: () async{},
          ),
          const SizedBox(height: 24),
          buildName(user),
        ],
      ),
    );
  }

  buildName(User user) => Column(
      children: [
        Text(
          user.name,
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
        ),
      ],
    );
  }
