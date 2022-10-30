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
          const SizedBox(height: 24),

          TextField(
            controller: emailController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Password'
            ),
            onChanged: (name) {},
          ),
          const SizedBox(height: 24),

          TextField(
            controller: emailController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Surname'
            ),
            onChanged: (name) {},
          ),
          const SizedBox(height: 24),

          TextField(
            controller: emailController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'middleName'
            ),
            onChanged: (name) {},
          ),
          const SizedBox(height: 24),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'code'
            ),
            onChanged: (name) {},
          ),
          const SizedBox(height: 24),
          // TextFieldWidget(
          //   lable: "Email",
          //   text: user.email,
          //   onChanged: (email) {},
          // ),
          // const SizedBox(height: 24),
          // TextFieldWidget(
          //   lable: "Phone Number",
          //   text: user.numberPhone,
          //   onChanged: (numberPhone) {},
          // ),
          // const SizedBox(height: 24),
          // TextFieldWidget(
          //   lable: "About",
          //   text: user.about,
          //   onChanged: (about) {},
          // ),
          // const SizedBox(height: 24),
          // TextFieldWidget(
          //   lable: "About",
          //   text: user.about,
          //   onChanged: (about) {},
          // ),
          // const SizedBox(height: 24),
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

Widget _input(Icon icon, String hint, TextEditingController controller, bool hidden){
  return Container(
    padding: EdgeInsets.only(right: 20, left: 20),
    child: TextField(
      controller: controller,
      obscureText: hidden,
      style: TextStyle(fontSize: 20, color: Colors.white),

      decoration: InputDecoration(
        hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white30),
        hintText: hint,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3)
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white54, width: 1)
        ),
        prefixIcon: Padding(padding: EdgeInsets.only(left: 10, right: 10),
          child: IconTheme(
            data: IconThemeData(
                color: Colors.yellow
            ),
            child: icon,
          ),
        ),
      ),
    ),
  );
}