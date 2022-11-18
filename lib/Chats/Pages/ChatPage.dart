import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Styles/Colors.dart';
import 'package:flutter/material.dart';

import '../Widgets/single_message.dart';

class ChatPage extends StatelessWidget {
  final String currentUserId;
  final String friendId;
  final String friendName;
  final String friendDescription;
  final String friendImage;

  ChatPage(
      {required this.currentUserId,
      required this.friendId,
      required this.friendName,
      required this.friendDescription,
      required this.friendImage,
      super.key});

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
              leading: CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(friendImage),
              ),
              title: Text(
                friendName,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(friendDescription,
                  style: TextStyle(color: Colors.white)),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                  child: Container(
                // decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(25),
                //         topRight: Radius.circular(25))),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(currentUserId)
                        .collection('messages')
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
                              bool isMe = snapshot.data.docs[index]
                                      ['senderId'] ==
                                  currentUserId;
                              return SingleMessage(
                                  message: snapshot.data.docs[index]['message'],
                                  isMe: isMe);
                            });
                      }
                      return Center(child: CircularProgressIndicator(
                        color: purpleColor,
                      ));
                    }),
              )),
              newMessage(currentUserId: currentUserId, friendId: friendId)
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
      "message": message,
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
      "message": message,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Row(
        children: [
          Expanded(
            child: Flexible(
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
                      //OutlineInputBorder(
                      //borderRadius: BorderRadius.circular(50.0)),
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
    );
  }
}
