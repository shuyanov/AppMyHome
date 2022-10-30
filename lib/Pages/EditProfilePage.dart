import 'package:command_flutter/Model/User.dart';
import 'package:command_flutter/Utils/UserPerefer.dart';
import 'package:command_flutter/Widget/ButtonWidget.dart';
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String email = '';

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Color.fromARGB( 200, 105, 193, 238),
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
          const SizedBox(height: 12),
          TextField(
            controller: emailController,
            onChanged: (name) {},
          ),

          const SizedBox(height: 12),
          TextFieldWidget(
            lable: "Email",
            text: user.email,
            onChanged: (email) {},
          ),
          const SizedBox(height: 12),
          TextFieldWidget(
            lable: "Phone Number",
            text: user.numberPhone,
            onChanged: (numberPhone) {},
          ),
          const SizedBox(height: 12),
          TextFieldWidget(
            lable: "About",
            text: user.about,
            onChanged: (about) {},
          ),
          const SizedBox(height: 12),
          TextFieldWidget(
            lable: "About",
            text: user.about,
            onChanged: (about) {},
          ),
          const SizedBox(height: 12),
          Expanded(
              child: Align(
                alignment: Alignment(1,1),
                child: buildEditProfileButton()),
              )
        ],
      ),
    ),
  );

Widget buildEditProfileButton() => ButtonWidget(
  text:'Edit',
  onClicked: (){
    email = emailController.text;
    print(email);
    PushToJson(
        user.email,
        user.about,
        user.name,
        user.name,
        user.name,
        user.about
    );
  },
);
}

