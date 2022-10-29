import 'package:flutter/material.dart';

class generalSingleMessage extends StatelessWidget {
  final String message;
  final bool isMe;
  generalSingleMessage({required this.message, required this.isMe});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(5),
            constraints: BoxConstraints(maxWidth: 200),
            decoration: BoxDecoration(
                color: isMe ? Colors.blue : Color.fromARGB(255, 174, 174, 174),
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
              ),
            )),
      ],
    );
  }
}
