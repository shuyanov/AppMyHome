import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../Styles/Colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Widgets/single_message.dart';

enum Menu { itemOne, itemTwo, itemThree }

class ChatPage extends StatefulWidget {
  final String currentUserId;
  final String friendId;
  final String friendSurname;
  final String friendName;
  final String friendMiddle_name;

  ChatPage(
      {required this.currentUserId,
      required this.friendId,
      required this.friendSurname,
      required this.friendName,
      required this.friendMiddle_name,
      super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/chat/backgroundChat.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            backgroundColor: purpleColor,
            title: ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: Image.asset(
                'assets/chat/resource30.png',
                scale: 3,
              ),
              title: Text(
                widget.friendSurname,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text("${widget.friendName} ${widget.friendMiddle_name}",
                  style: TextStyle(color: Colors.white)),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                  child: Container(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(widget.currentUserId)
                        .collection('messages')
                        .doc(widget.friendId)
                        .collection('chats')
                        .orderBy("date", descending: true)
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.docs.length < 1) {
                          return Center(
                            child: Text("Скажите что нибудь"),
                          );
                        }
                        return ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            reverse: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              bool isMe = snapshot.data.docs[index]
                                      ['senderId'] ==
                                  widget.currentUserId;
                              Timestamp date =
                                  snapshot.data.docs[index]['date'];
                              String type = snapshot.data.docs[index]['type'];
                              return SingleMessage(
                                message: snapshot.data.docs[index]['message'],
                                file: snapshot.data.docs[index]['file'],
                                nameFile: snapshot.data.docs[index]['fileName'],
                                isMe: isMe,
                                dateMessage: date,
                                type: type,
                              );
                            });
                      }
                      return Center(
                          child: CircularProgressIndicator(
                        color: purpleColor,
                      ));
                    }),
              )),
              newMessage(
                  currentUserId: widget.currentUserId,
                  friendId: widget.friendId)
            ],
          )),
    );
  }
}

// Виджет для написания нового сообщения
class newMessage extends StatefulWidget {
  //final User currentUser;
  final String currentUserId;
  final String friendId;
  const newMessage(
      {required this.currentUserId, required this.friendId, super.key});

  @override
  State<newMessage> createState() => _newMessageState();
}

class _newMessageState extends State<newMessage> {
  final _controller = TextEditingController();
  final _controllerFile = TextEditingController();

  void sendMessage() async {
    String message = _controller.text;
    _controller.clear();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.currentUserId)
        .collection('messages')
        .doc(widget.friendId)
        .collection('chats')
        .add({
      "senderId": widget.currentUserId,
      "receiverId": widget.friendId,
      "file": "",
      "fileName": "",
      "message": message.trim(),
      "type": "text",
      "date": DateTime.now(),
    }).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.currentUserId)
          .collection('messages')
          .doc(widget.friendId)
          .set({
        'last_msg': message,
      });
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.friendId)
        .collection('messages')
        .doc(widget.currentUserId)
        .collection("chats")
        .add({
      "senderId": widget.currentUserId,
      "receiverId": widget.friendId,
      "file": "",
      "fileName": "",
      "message": message.trim(),
      "type": "text",
      "date": DateTime.now(),
    }).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.friendId)
          .collection('messages')
          .doc(widget.currentUserId)
          .set({"last_msg": message});
    });
  }

  // PICK FILE
  File? file;
  PlatformFile? pickedFile;
  Future getFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
      if (pickedFile != null) {
        file = File(pickedFile!.path!);
        showDialog(
            context: context,
            builder: (context) => Container(
                  child: AlertDialog(
                    contentPadding: EdgeInsets.all(5),
                    titlePadding: EdgeInsets.all(5),
                    actionsPadding: EdgeInsets.all(5),
                    title: Text("Подтвердить?"),
                    content: Container(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.insert_drive_file,
                          size: 50,
                        ),
                        SizedBox(
                            height: 50,
                            child: Center(child: Text(pickedFile!.name))),
                        SizedBox(
                          child: Row(
                            children: [
                              Flexible(
                                child: TextFormField(
                                  minLines: 1,
                                  maxLines: 2,
                                  controller: _controllerFile,
                                  scrollPadding: EdgeInsets.all(1),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 2),
                                      border: InputBorder.none,
                                      hintText: "Напишите сообщение..."),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _controllerFile.clear();
                                },
                                icon: Icon(
                                  Icons.close,
                                  size: 20,
                                ),
                                splashRadius: 20,
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
                    actions: [
                      TextButton(
                          onPressed: () {
                            checkedFile = false;
                            uploadFile();
                            Navigator.pop(context);
                          },
                          child: Text("Нет")),
                      TextButton(
                          onPressed: () {
                            if (_controller.text.trim() != "") sendMessage();
                            checkedFile = true;
                            uploadFile();
                            Navigator.pop(context);
                          },
                          child: Text("Да"))
                    ],
                  ),
                ));
      }
    });
  }

// SEND FILES
  bool checkedFile = false;
  Future uploadFile() async {
    String fileName = Uuid().v1();

    if (checkedFile == true) {
      int status = 1;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.currentUserId)
          .collection('messages')
          .doc(widget.friendId)
          .collection('chats')
          .doc(fileName)
          .set({
        "senderId": widget.currentUserId,
        "receiverId": widget.friendId,
        "file": "",
        "fileName": "",
        "message": "",
        "type": "file",
        "date": DateTime.now(),
      }).then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(widget.currentUserId)
            .collection('messages')
            .doc(widget.friendId)
            .set({
          'last_msg': "file",
        });
      });
      var dateNow = DateTime.now();
      var dateFormat = new DateFormat('dd.MM.yyyy');
      var date = dateFormat.format(dateNow);
      var anyFile = FirebaseStorage.instance
          .ref()
          .child('files/${date}')
          .child('${fileName}');
      var uploadTask = await anyFile.putFile(file!).catchError((error) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.currentUserId)
            .collection('messages')
            .doc(widget.friendId)
            .collection('chats')
            .doc(fileName)
            .delete();

        status = 0;
      });
      if (status == 1) {
        String fileUrl = await uploadTask.ref.getDownloadURL();
        String messagefile = _controllerFile.text;
        _controllerFile.clear();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.currentUserId)
            .collection('messages')
            .doc(widget.friendId)
            .collection('chats')
            .doc(fileName)
            .update({
          'file': fileUrl,
          'fileName': pickedFile!.name,
          'message': messagefile.trim()
        });

        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.friendId)
            .collection('messages')
            .doc(widget.currentUserId)
            .collection("chats")
            .add({
          "senderId": widget.currentUserId,
          "receiverId": widget.friendId,
          "file": fileUrl,
          "fileName": pickedFile!.name,
          "message": messagefile.trim(),
          "type": "file",
          "date": DateTime.now(),
        }).then((value) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(widget.friendId)
              .collection('messages')
              .doc(widget.currentUserId)
              .set({"last_msg": "file"});
        });
        print("Файл: $fileUrl");
      }
    } else {
      getFile();
    }
  }

  // PICK IMAGE
  File? imageFile;
  String? xFileName;
  String? fileName;
  Future getImage() async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null){
      setState(() {
        imageFile = File(xFile.path);
        xFileName = xFile.name;
        fileName = xFileName!.split("image_picker").last;
        showDialog(
            context: context,
            builder: (context) => Container(
                  child: AlertDialog(
                    contentPadding: EdgeInsets.all(5),
                    titlePadding: EdgeInsets.all(5),
                    actionsPadding: EdgeInsets.all(5),
                    title: Text("Подтвердить?"),
                    content: Container(
                        child: Column(
                      children: [
                        Expanded(
                            child: Image.file(
                          File(xFile.path),
                          fit: BoxFit.cover,
                        )),
                        SizedBox(
                          child: Row(
                            children: [
                              Flexible(
                                child: TextFormField(
                                  minLines: 1,
                                  maxLines: 2,
                                  controller: _controllerFile,
                                  scrollPadding: EdgeInsets.all(1),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 2),
                                      border: InputBorder.none,
                                      hintText: "Напишите сообщение..."),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _controllerFile.clear();
                                },
                                icon: Icon(
                                  Icons.close,
                                  size: 20,
                                ),
                                splashRadius: 20,
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
                    actions: [
                      TextButton(
                          onPressed: () {
                            checkedImage = false;
                            uploadImage();
                            Navigator.pop(context);
                          },
                          child: Text("Нет")),
                      TextButton(
                          onPressed: () {
                            if (_controller.text.trim() != "") sendMessage();
                            checkedImage = true;
                            uploadImage();
                            Navigator.pop(context);
                          },
                          child: Text("Да"))
                    ],
                  ),
                ));
      });
      }
    });
  }

  // SEND IMAGE
  bool checkedImage = false;
  Future uploadImage() async {
    String fileName = Uuid().v1();

    if (checkedImage == true) {
      int status = 1;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.currentUserId)
          .collection('messages')
          .doc(widget.friendId)
          .collection('chats')
          .doc(fileName)
          .set({
        "senderId": widget.currentUserId,
        "receiverId": widget.friendId,
        "file": "",
        "fileName": "",
        "message": "",
        "type": "image",
        "date": DateTime.now(),
      }).then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(widget.currentUserId)
            .collection('messages')
            .doc(widget.friendId)
            .set({
          'last_msg': "image",
        });
      });
      var dateNow = DateTime.now();
      var dateFormat = new DateFormat('dd.MM.yyyy');
      var date = dateFormat.format(dateNow);
      var img = FirebaseStorage.instance
          .ref()
          .child('images/${date}')
          .child('${fileName}.png');
      var uploadTask = await img.putFile(imageFile!).catchError((error) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.currentUserId)
            .collection('messages')
            .doc(widget.friendId)
            .collection('chats')
            .doc(fileName)
            .delete();

        status = 0;
      });
      if (status == 1) {
        String imageUrl = await uploadTask.ref.getDownloadURL();
        String messagefile = _controllerFile.text;
        _controllerFile.clear();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.currentUserId)
            .collection('messages')
            .doc(widget.friendId)
            .collection('chats')
            .doc(fileName)
            .update({'file': imageUrl, 'message': messagefile.trim()});

        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.friendId)
            .collection('messages')
            .doc(widget.currentUserId)
            .collection("chats")
            .add({
          "senderId": widget.currentUserId,
          "receiverId": widget.friendId,
          "file": imageUrl,
          "fileName": "",
          "message": messagefile.trim(),
          "type": "image",
          "date": DateTime.now(),
        }).then((value) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(widget.friendId)
              .collection('messages')
              .doc(widget.currentUserId)
              .set({"last_msg": "image"});
        });
        print("Изображение: $imageUrl");
      }
    } else {
      getImage();
    }
  }

  // PICK VIDEO
  File? videoFile;
  Future getVideo() async {
    ImagePicker _picker = ImagePicker();

    await _picker.pickVideo(source: ImageSource.gallery).then((xFile) {
      if (xFile != null){
      setState(() {
        videoFile = File(xFile.path);
        xFileName = xFile.name;
        fileName = xFileName!.split("image_picker").last;
        showDialog(
            context: context,
            builder: (context) => Container(
                  child: AlertDialog(
                    contentPadding: EdgeInsets.all(5),
                    titlePadding: EdgeInsets.all(5),
                    actionsPadding: EdgeInsets.all(5),
                    title: Text("Подтвердить?"),
                    content: Container(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.video_file,
                          size: 50,
                        ),
                        Center(child: Text(fileName!)),
                        SizedBox(
                          child: Row(
                            children: [
                              Flexible(
                                child: TextFormField(
                                  minLines: 1,
                                  maxLines: 2,
                                  controller: _controllerFile,
                                  scrollPadding: EdgeInsets.all(1),
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 2),
                                      border: InputBorder.none,
                                      hintText: "Напишите сообщение..."),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _controllerFile.clear();
                                },
                                icon: Icon(
                                  Icons.close,
                                  size: 20,
                                ),
                                splashRadius: 20,
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
                    actions: [
                      TextButton(
                          onPressed: () {
                            checkedVideo = false;
                            uploadVideo();
                            Navigator.pop(context);
                          },
                          child: Text("Нет")),
                      TextButton(
                          onPressed: () {
                            if (_controller.text.trim() != "") sendMessage();
                            checkedVideo = true;
                            uploadVideo();
                            Navigator.pop(context);
                          },
                          child: Text("Да"))
                    ],
                  ),
                ));
      });
  }
    });
  }

  // SEND VIDEO
  bool checkedVideo = false;
  Future uploadVideo() async {
    String fileName = Uuid().v1();
    if (checkedVideo == true) {
      int status = 1;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.currentUserId)
          .collection('messages')
          .doc(widget.friendId)
          .collection('chats')
          .doc(fileName)
          .set({
        "senderId": widget.currentUserId,
        "receiverId": widget.friendId,
        "file": "",
        "fileName": "",
        "message": "",
        "type": "video",
        "date": DateTime.now(),
      }).then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(widget.currentUserId)
            .collection('messages')
            .doc(widget.friendId)
            .set({
          'last_msg': "video",
        });
      });
      var dateNow = DateTime.now();
      var dateFormat = new DateFormat('dd.MM.yyyy');
      var date = dateFormat.format(dateNow);
      var mp4 = FirebaseStorage.instance
          .ref()
          .child('videos/${date}')
          .child('${fileName}.mp4');
      var uploadTask = await mp4.putFile(videoFile!).catchError((error) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.currentUserId)
            .collection('messages')
            .doc(widget.friendId)
            .collection('chats')
            .doc(fileName)
            .delete();

        status = 0;
      });
      if (status == 1) {
        String videoUrl = await uploadTask.ref.getDownloadURL();
        String messagefile = _controllerFile.text;
        _controllerFile.clear();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.currentUserId)
            .collection('messages')
            .doc(widget.friendId)
            .collection('chats')
            .doc(fileName)
            .update({'file': videoUrl, 'message': messagefile.trim()});
        print("Видео: $videoUrl");

        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.friendId)
            .collection('messages')
            .doc(widget.currentUserId)
            .collection("chats")
            .add({
          "senderId": widget.currentUserId,
          "receiverId": widget.friendId,
          "file": videoUrl,
          "fileName": "",
          "message": messagefile.trim(),
          "type": "video",
          "date": DateTime.now(),
        }).then((value) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(widget.friendId)
              .collection('messages')
              .doc(widget.currentUserId)
              .set({"last_msg": "video"});
        });
      }
    } else {
      getVideo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Row(
        children: [
          PopupMenuButton(
            tooltip: "",
            onSelected: (Menu item) {
              switch (item) {
                case Menu.itemOne:
                  _controllerFile.clear();
                  getImage();
                  break;
                case Menu.itemTwo:
                  _controllerFile.clear();
                  getVideo();
                  break;
                case Menu.itemThree:
                  _controllerFile.clear();
                  getFile();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
              const PopupMenuItem(
                value: Menu.itemOne,
                child: Text('Фото'),
              ),
              const PopupMenuItem(
                value: Menu.itemTwo,
                child: Text('Видео'),
              ),
              const PopupMenuItem(
                value: Menu.itemThree,
                child: Text('Файлы'),
              ),
            ],
            icon: Icon(Icons.add),
            splashRadius: 20,
          ),
          Flexible(
            child: SizedBox(
              child: TextFormField(
                minLines: 1,
                maxLines: 2,
                controller: _controller,
                scrollPadding: EdgeInsets.all(1),
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                    border: InputBorder.none,
                    hintText: "Напишите сообщение..."),
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              if (_controller.text.trim() != "") sendMessage();
            },
            icon: Icon(Icons.send),
            splashRadius: 20,
          )
        ],
      ),
    );
  }
}
