import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class generalSingleMessage1 extends StatelessWidget {
  final String message;
  final bool isMe;
  final Timestamp dateMessage;
  final String name;
  final int count;

  generalSingleMessage1(
      {required this.message,
      required this.isMe,
      required this.dateMessage,
      required this.name,
      required this.count});

  @override
  Widget build(BuildContext context) {
    var dateFormat = new DateFormat('dd MMMM yyyy');
    String dateNow = dateFormat.format(DateTime.now());
    String sendDate = dateFormat.format(dateMessage.toDate());
    var format = new DateFormat('HH:mm');
    String time = format.format(dateMessage.toDate());

    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(sendDate)),
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(5),
                constraints: BoxConstraints(maxWidth: 250),
                decoration: BoxDecoration(
                    color:
                        isMe ? Colors.blue : Color.fromARGB(255, 174, 174, 174),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          constraints: BoxConstraints(minWidth: 50),
                          child: Text(
                            name,
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                        ),
                        Text(
                          message,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      textAlign: TextAlign.right,
                      time,
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ],
                )),
          ],
        ),
      ],
    );
  }
}
