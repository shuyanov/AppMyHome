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
  TextEditingController nameController = TextEditingController();
  TextEditingController Midle_nameController = TextEditingController();
  TextEditingController SurnameController = TextEditingController();
  String email = '';
  String password = '';
  String name = '';
  String Midle_name = '';
  String Surname = '';

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
            controller: passwordController,
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
            controller: SurnameController,
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
            controller: Midle_nameController,
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
            controller: nameController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'name'
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

