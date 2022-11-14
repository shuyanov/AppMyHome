import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Styles/Colors.dart';
import '/GeneralChats/Widgets/generalSingleMessage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
int count = 1;
    List<String> listDate = [];

class GeneralPage extends StatelessWidget {
  final String currentUserId;
  final String currentName;
  final String currentImage;
  final String generalId;
  final String generalName;
  final String generalImage;

  GeneralPage(
      {required this.currentUserId,
      required this.currentName,
      required this.currentImage,
      required this.generalId,
      required this.generalName,
      required this.generalImage,
      super.key});
  @override
  Widget build(BuildContext context) {
    
    // DateTime now = DateTime.now();
    // String formattedDate = DateFormat('dd-MM-yyyy').format(now);
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
                'assets/chat/resource31.png',
                scale: 3,
              ),
              title: Text(generalName, style: TextStyle(color: Colors.white)),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                  child: Container(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('general')
                        .doc(generalId)
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
                              Timestamp date =
                                  snapshot.data.docs[index]['date'];
                              var dateFormat = new DateFormat('dd.MM.yyyy');
                              String name =
                                  snapshot.data.docs[index]['senderName'];

                              return Column(
                                children: [
                                  generalSingleMessage(
                                      message: snapshot.data.docs[index]
                                          ['message'],
                                      isMe: isMe,
                                      dateMessage: date,
                                      name: name,
                                      generalId: generalId),                                    
                                ],
                              );
                            });
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
              )),
              newMessage(
                  currentUserId: currentUserId,
                  currentName: currentName,
                  currentImage: currentImage,
                  generalId: generalId,
                  generalName: generalName,
                  generalImage: generalImage)
            ],
          ),
        ));
  }
}

// Виджет для написания нового сообщения
class newMessage extends StatelessWidget {
  final String currentUserId;
  final String currentName;
  final String currentImage;
  final String generalId;
  final String generalName;
  final String generalImage;

  newMessage({
    required this.currentUserId,
    required this.currentName,
    required this.currentImage,
    required this.generalId,
    required this.generalName,
    required this.generalImage,
  });

  final _controller = TextEditingController();
  void sendMessage() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd.MM.yyyy').format(now);
    String message = _controller.text;
    _controller.clear();
    await FirebaseFirestore.instance
        .collection('general')
        .doc(generalId)
        .collection('chats')
        .add({
      "senderId": currentUserId,
      "receiverId": generalId,
      "senderName": currentName,
      "message": message,
      "type": "text",
      "date": DateTime.now(),
    }).then((value) {
      FirebaseFirestore.instance
          .collection('general')
          .doc(generalId)
          .collection('message')
          .doc(currentUserId)
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
