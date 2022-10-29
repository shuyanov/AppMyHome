import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:command_flutter/Chats/Data/Admin.dart';
import 'package:command_flutter/Chats/Widgets/single_message.dart';
import 'package:command_flutter/GeneralChats/Widgets/generalSingleMessage.dart';
import 'package:flutter/material.dart';

class GeneralPage extends StatelessWidget {
  final String currentUserId;
  final String friendId;
  final String friendName;
  final String friendImage;

  GeneralPage({
    required this.currentUserId,
    required this.friendId,
    required this.friendName,
    required this.friendImage,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: ListTile(
            leading: CircleAvatar(
              radius: 20.0,
              backgroundImage: NetworkImage(friendImage),
            ),
            title: Text(friendName, style: TextStyle(color: Colors.white)),
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(currentUserId)
                      .collection('general')
                      .doc(friendId)
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
                            bool isMe = snapshot.data.docs[index]['senderId'] ==
                                currentUserId;
                            return generalSingleMessage(
                                message: snapshot.data.docs[index]['message'],
                                isMe: isMe);
                          });
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            )),
            newMessage(currentUserId: currentUserId, friendId: friendId)
          ],
        ));
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

  void sendMessage() async {
    String message = _controller.text;
    _controller.clear();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.currentUserId)
        .collection('general')
        .doc(widget.friendId)
        .collection('chats')
        .add({
      "senderId": widget.currentUserId,
      "receiverId": widget.friendId,
      "message": message,
      "type": "text",
      "date": DateTime.now(),
    }).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.currentUserId)
          .collection('general')
          .doc(widget.friendId)
          .set({
        'last_msg': message,
      });
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.friendId)
        .collection('general')
        .doc(widget.currentUserId)
        .collection("chats")
        .add({
      "senderId": widget.currentUserId,
      "receiverId": widget.friendId,
      "message": message,
      "type": "text",
      "date": DateTime.now(),
    }).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.friendId)
          .collection('general')
          .doc(widget.currentUserId)
          .set({"last_msg": message});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Flexible(
                child: SizedBox(
                  child: TextFormField(
                    controller: _controller,
                    scrollPadding: EdgeInsets.all(1),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                        hintText: "Напишите сообщение..."),
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () async {
                  sendMessage();
                },
                icon: Icon(Icons.send))
          ],
        ),
      ),
    );
  }
}
