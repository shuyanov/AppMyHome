import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class generalSingleMessage extends StatelessWidget {
  final String message;
  final bool isMe;
  final Timestamp dateMessage;
  final String name;
  final String generalId;
  // final String dateMessage;
  //final int count;

  generalSingleMessage(
      {required this.message,
      required this.isMe,
      required this.dateMessage,
      required this.name,
      required this.generalId,
      // required this.dateMessage,
      //required this.count
      });

  @override
  Widget build(BuildContext context) {
    var dateFormat = new DateFormat('dd.MM.yyyy');
    var dateFormatNoYear = new DateFormat('dd.MM');
    var yearFormat = new DateFormat('yyyy');
    String sendDate = dateFormat.format(dateMessage.toDate());
    String sendDateNoYear = dateFormatNoYear.format(dateMessage.toDate());
    String dateNow = dateFormat.format(DateTime.now());
    var now = DateTime.now();
    var yearNow = yearFormat.format(DateTime(now.year));
    var sendYear = yearFormat.format(DateTime(dateMessage.toDate().year));
    var yesterday = DateTime(now.year, now.month, now.day - 1);
    String dateYesterday = dateFormat.format(yesterday);
    var format = new DateFormat('HH:mm');
    String time = format.format(dateMessage.toDate());

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(5),
                constraints: BoxConstraints(maxWidth: 250),
                decoration: BoxDecoration(
                    color: isMe ? Color.fromARGB(255, 170, 143, 255) : Colors.white,
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
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Text(
                          message,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      textAlign: TextAlign.right,
                      time,
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                  ],
                ),
            ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
             dateNow == sendDate ? "" : dateYesterday == sendDate ? "Вчера" : yearNow == sendYear ? "${sendDateNoYear}" : "${sendDate}", style: TextStyle(fontSize: 10),),
          ),
          ],
        ),
      ],
    );
  }
}
