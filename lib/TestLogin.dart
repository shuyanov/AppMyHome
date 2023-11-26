import 'package:flutter/material.dart';

// class TestLogin extends StatelessWidget {

//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   //MS
//   TextEditingController nameController = TextEditingController();
//   TextEditingController surNameController = TextEditingController();
//   TextEditingController middleNameController = TextEditingController();

//   String name = "";
//   String surName = "";
//   String middleName = "";
//   //MS

//   bool logged = false;
//   String email = "";
//   String password = "";


class ShowDialogg extends StatelessWidget {
  const ShowDialogg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        TextButton(
          child: Text("OK"),
          onPressed: () {},
        ),
      ],
    );
  }
}