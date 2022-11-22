import 'dart:async';
import 'package:flutter/material.dart';

class ButtonLoginReg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: showAlertDialog(context)
    );
  }

  showAlertDialog(BuildContext context) {
    TextEditingController emailController = TextEditingController();

    String email = '';
    email = emailController.text;

    Future<void> _LoginButtonActio() async {
      email = emailController.text;
      print("login: login = ${email}");
      emailController.clear();
      print("login: login = ${email}");
    }

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () => Navigator.pop(context, 'Cancel'),
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.pop(context, 'Cancel');
        _LoginButtonActio(); },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Необходимо ввести @mail УК, для отправления писем"),
      content: TextField(
        controller: emailController,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            labelText: 'Email'
        ),
        onChanged: (name) {},
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
