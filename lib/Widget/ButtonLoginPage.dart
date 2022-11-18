import 'package:command_flutter/RegisterPage.dart';
import 'package:flutter/material.dart';

class ButtonLoginReg extends StatelessWidget {
  const ButtonLoginReg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 1),
        height: 36,
        width: 150,
        child: ElevatedButton(
          child: Text("регистрация", style: TextStyle(color: Colors.white, fontSize: 19)),
          onPressed: (){ print('tap-tap');
          {
            showAlertDialog(context);
            if(1 == 2){
              return runApp(RegisterPage());}
          };
          },
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(200, 158, 122, 244),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        )
    );
  }

  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () => Navigator.pop(context, 'Cancel'),
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () => Navigator.pop(context, 'Cancel'),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Необходимо ввести @mail УК, для отправления писем"),
      content: TextField(
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
