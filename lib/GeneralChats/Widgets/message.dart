import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../../Styles/Colors.dart';
import '../../functions/downloadFile.dart';
import '../../functions/showImage.dart';
import '../../functions/showVideo.dart';

class messageWidget extends StatelessWidget {
  final String message;
  final String file;
  final String nameFile;
  final bool isMe;
  final Timestamp dateMessage;
  final String name;
  final String type;

  messageWidget({
    required this.message,
    required this.file,
    required this.nameFile,
    required this.isMe,
    required this.dateMessage,
    required this.name,
    required this.type,
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
              margin: EdgeInsets.all(5),
              constraints: BoxConstraints(maxWidth: 200),
              decoration: BoxDecoration(
                  color: isMe ? purpleColorMessages : Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        constraints: BoxConstraints(minWidth: 50),
                        child: Text(
                          name,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      type == 'text'
                          ? Container(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Text(
                                message,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            )
                          : type == 'image'
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        InkWell(
                                          onTap: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (_) => showImage(
                                                      imageURL: file))),
                                          child: Container(
                                            constraints: BoxConstraints(
                                                minWidth: 100, minHeight: 50),
                                            padding: EdgeInsets.all(2),
                                            child: file != ""
                                                ? Container(
                                                    constraints: BoxConstraints(
                                                        minWidth: 200,
                                                        minHeight: 50),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                      child: Image.network(file,
                                                          fit: BoxFit.contain,
                                                          alignment:
                                                              Alignment.center,
                                                          errorBuilder: (context,
                                                                  url, error) =>
                                                              Center(
                                                                  child:
                                                                      new Text(
                                                                "Картинка недоступна.\n Возможно нет интернета или картинка не действительна",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              )),
                                                          loadingBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  Widget child,
                                                                  ImageChunkEvent?
                                                                      loadingProgress) {
                                                            if (loadingProgress ==
                                                                null)
                                                              return child;
                                                            return Center(
                                                                child:
                                                                    CircularProgressIndicator(
                                                              color:
                                                                  purpleColor,
                                                              value: loadingProgress
                                                                          .expectedTotalBytes !=
                                                                      null
                                                                  ? loadingProgress
                                                                          .cumulativeBytesLoaded /
                                                                      loadingProgress
                                                                          .expectedTotalBytes!
                                                                  : null,
                                                            ));
                                                          }),
                                                    ),
                                                  )
                                                : Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                            color: purpleColor),
                                                  ),
                                          ),
                                        ),
                                        if (message == "")
                                          Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                  margin: EdgeInsets.all(8),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 5),
                                                  // width: 30,
                                                  // height: 10,
                                                  child: Text(
                                                    time,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white),
                                                  )))
                                      ],
                                    ),
                                    if (message != "")
                                      Container(
                                        padding:
                                            EdgeInsets.only(left: 5, right: 5),
                                        child: Text(
                                          message,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                  ],
                                )
                              : type == 'video'
                                  ? Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            InkWell(
                                              onTap: () => Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                      builder: (_) => showVideo(
                                                          videoURL: file))),
                                              child: Container(
                                                alignment: Alignment.center,
                                                constraints: BoxConstraints(
                                                    minWidth: 100,
                                                    minHeight: 50),
                                                child: file != ""
                                                    ? Icon(
                                                        Icons.video_file,
                                                        size: 50,
                                                      )
                                                    : Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: purpleColor,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                            Positioned(
                                                child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              child: Text(
                                                "Видео",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: greyText),
                                              ),
                                            ))
                                          ],
                                        ),
                                        if (message != "")
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 5, left: 5, right: 5),
                                            child: Text(
                                              message,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                      ],
                                    )
                                  : Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                            title: Text(
                                                                "Открывается файл"),
                                                            content: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Center(
                                                                  child: CircularProgressIndicator(
                                                                      color:
                                                                          purpleColor),
                                                                ),
                                                              ],
                                                            )));
                                                Timer(Duration(seconds: 10),
                                                    () {
                                                  Navigator.pop(context);
                                                });

                                                download(file, nameFile);
                                              },
                                              child: Container(
                                                constraints: BoxConstraints(
                                                    minWidth: 100,
                                                    minHeight: 50),
                                                alignment: Alignment.center,
                                                child: file != ""
                                                    ? Center(
                                                        child: Column(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .insert_drive_file,
                                                              size: 50,
                                                            ),
                                                            Text(nameFile),
                                                          ],
                                                        ),
                                                      )
                                                    : Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: purpleColor,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                            Positioned(
                                                child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              child: Text(
                                                "Файл",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: greyText),
                                              ),
                                            ))
                                          ],
                                        ),
                                        if (message != "")
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 5, left: 5, right: 5),
                                            child: Text(
                                              message,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                    ],
                  ),
                  type != 'image' || message != ''
                      ? Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            textAlign: TextAlign.right,
                            time,
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                dateNow == sendDate
                    ? ""
                    : dateYesterday == sendDate
                        ? "Вчера"
                        : yearNow == sendYear
                            ? "${sendDateNoYear}"
                            : "${sendDate}",
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
