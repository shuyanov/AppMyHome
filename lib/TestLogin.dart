
import 'package:flutter/material.dart';


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
