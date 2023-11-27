import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../Styles/Colors.dart';
import '../../functions/downloadFile.dart';
import '../../functions/showImage.dart';
import '../../functions/showVideo.dart';

enum Menu { itemOne, itemTwo, itemThree }

class messageWidget extends StatefulWidget {
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
  State<messageWidget> createState() => _messageWidgetState();
}

class _messageWidgetState extends State<messageWidget> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.file))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var dateFormat = new DateFormat('dd.MM.yyyy');
    var dateFormatNoYear = new DateFormat('dd.MM');
    var yearFormat = new DateFormat('yyyy');
    String sendDate = dateFormat.format(widget.dateMessage.toDate());
    String sendDateNoYear =
        dateFormatNoYear.format(widget.dateMessage.toDate());
    String dateNow = dateFormat.format(DateTime.now());
    var now = DateTime.now();
    var yearNow = yearFormat.format(DateTime(now.year));
    var sendYear =
        yearFormat.format(DateTime(widget.dateMessage.toDate().year));
    var yesterday = DateTime(now.year, now.month, now.day - 1);
    String dateYesterday = dateFormat.format(yesterday);
    var format = new DateFormat('HH:mm');
    String time = format.format(widget.dateMessage.toDate());
    final Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment:
          widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                margin: EdgeInsets.all(5),
                constraints: BoxConstraints(maxWidth: 200),
                decoration: BoxDecoration(
                    color: widget.isMe ? purpleColorMessages : Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: InkWell(
                  focusColor: Colors.black,
                  hoverColor: Colors.black,
                  splashColor: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  onLongPress: () {
                    if ((widget.type != 'text') && widget.message != '')
                      Clipboard.setData(new ClipboardData(
                              text:
                                  "${widget.name}: (${widget.type}) ${widget.message}\n- "))
                          .then((_) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            padding: EdgeInsets.all(16),
                            content: Text(
                              "Скопировано!",
                              textAlign: TextAlign.center,
                            ),
                            shape: StadiumBorder(),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.black.withOpacity(0.5),
                            width: 125,
                            duration: Duration(seconds: 1),
                          ),
                        );
                      });
                    else if (widget.type == 'text') {
                      Clipboard.setData(new ClipboardData(
                              text: "${widget.name}: ${widget.message}\n- "))
                          .then((_) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            padding: EdgeInsets.all(16),
                            content: Text(
                              "Скопировано!",
                              textAlign: TextAlign.center,
                            ),
                            shape: StadiumBorder(),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.black.withOpacity(0.5),
                            width: 125,
                            duration: Duration(seconds: 1),
                          ),
                        );
                      });
                    }
                  },
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
                              widget.isMe ? "Я" : widget.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          widget.type == 'text'
                              ? Container(
                                  constraints: BoxConstraints(minWidth: 100),
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: Text(
                                    widget.message,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              : widget.type == 'image'
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
                                                      builder: (_) => showImage(
                                                          imageURL:
                                                              widget.file))),
                                              child: Container(
                                                constraints: BoxConstraints(
                                                    minWidth: 100,
                                                    minHeight: 50),
                                                padding: EdgeInsets.all(2),
                                                child: widget.file != ""
                                                    ? Container(
                                                        constraints:
                                                            BoxConstraints(
                                                                minWidth: 200,
                                                                minHeight: 50),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                          child: Image.network(
                                                              widget.file,
                                                              fit: BoxFit
                                                                  .contain,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              errorBuilder: (context,
                                                                      url,
                                                                      error) =>
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
                                                                      Widget
                                                                          child,
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
                                                                color:
                                                                    purpleColor),
                                                      ),
                                              ),
                                            ),
                                            if (widget.message == "")
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
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2,
                                                              horizontal: 5),
                                                      // width: 30,
                                                      // height: 10,
                                                      child: Text(
                                                        time,
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color:
                                                                Colors.white),
                                                      )))
                                          ],
                                        ),
                                        if (widget.message != "")
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: Text(
                                              widget.message,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                      ],
                                    )
                                  : widget.type == 'video'
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
                                                  onTap: () => Navigator.of(
                                                          context)
                                                      .push(MaterialPageRoute(
                                                          builder: (_) =>
                                                              showVideo(
                                                                  videoURL: widget
                                                                      .file))),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(2),
                                                    alignment: Alignment.center,
                                                    constraints:
                                                        const BoxConstraints(
                                                            minWidth: 100,
                                                            minHeight: 50),
                                                    child: widget.file != ""
                                                        ? _controller.value
                                                                .isInitialized
                                                            ? ClipRRect(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                                // width: size.width,
                                                                // height: size.height,
                                                                child:
                                                                    AspectRatio(
                                                                  aspectRatio:
                                                                      _controller
                                                                          .value
                                                                          .aspectRatio,
                                                                  child: Stack(
                                                                    children: [
                                                                      VideoPlayer(
                                                                          _controller),
                                                                      const Center(
                                                                          child: Icon(
                                                                              Icons.play_arrow,
                                                                              size: 50,
                                                                              color: Colors.white))
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            : SizedBox(
                                                            height: 100,
                                                            child: Center(
                                                              child: CircularProgressIndicator(
                                                                  color:
                                                                      purpleColor),
                                                            ),
                                                          )
                                                        : SizedBox(
                                                            height: 100,
                                                            child: Center(
                                                              child: CircularProgressIndicator(
                                                                  color:
                                                                      purpleColor),
                                                            ),
                                                          ),
                                                  ),
                                                ),
                                                if (widget.message == "")
                                                  Positioned(
                                                      bottom: 0,
                                                      right: 0,
                                                      child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.4),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                          ),
                                                          margin:
                                                              EdgeInsets.all(8),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 2,
                                                                  horizontal:
                                                                      5),
                                                          // width: 30,
                                                          // height: 10,
                                                          child: Text(
                                                            time,
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .white),
                                                          )))
                                              ],
                                            ),
                                            if (widget.message != "")
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: 5, left: 5, right: 5),
                                                child: Text(
                                                  widget.message,
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

                                                    download(widget.file,
                                                        widget.nameFile);
                                                  },
                                                  child: Container(
                                                    constraints: BoxConstraints(
                                                        minWidth: 100,
                                                        minHeight: 50),
                                                    alignment: Alignment.center,
                                                    child: widget.file != ""
                                                        ? Center(
                                                            child: Column(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .insert_drive_file,
                                                                  size: 50,
                                                                ),
                                                                Text(widget
                                                                    .nameFile),
                                                              ],
                                                            ),
                                                          )
                                                        : Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              color:
                                                                  purpleColor,
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
                                            if (widget.message != "")
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: 5, left: 5, right: 5),
                                                child: Text(
                                                  widget.message,
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
                      (widget.type != 'image' || widget.message != '') &&
                              (widget.type != 'video' || widget.message != '')
                          ? Container(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                textAlign: TextAlign.right,
                                time,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
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
