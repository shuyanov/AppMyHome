import 'package:flutter/material.dart';

import '../../Styles/Colors.dart';

class SingleMessage extends StatelessWidget {
  final String message;
  final bool isMe;
  SingleMessage({required this.message, required this.isMe});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(5),
            constraints: BoxConstraints(maxWidth: 250, minWidth: 50),
            decoration: BoxDecoration(
                color: isMe ? purpleColorMessages : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Text(
              message,
              style: TextStyle(
                //fontSize: 16,
                color: Colors.black,
              ),
            )),
      ],
    );
  }
}
