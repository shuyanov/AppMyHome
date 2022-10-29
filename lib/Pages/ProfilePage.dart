import 'package:command_flutter/LoginPage.dart';
import 'package:command_flutter/Model/User.dart';
import 'package:command_flutter/Pages/EditProfilePage.dart';
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
  @override
  Widget build(BuildContext context) {
    final user = UserPereferences.myUser;
    return Scaffold(
      backgroundColor: Color.fromARGB(200, 105, 193, 238),
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

            const SizedBox(height: 350),
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
          user.name,
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
        ),
        Text(
          user.email,
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
