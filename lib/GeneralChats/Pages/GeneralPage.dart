import 'package:cloud_firestore/cloud_firestore.dart';
import '/GeneralChats/Widgets/generalSingleMessage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// class GroupDate extends StatelessWidget {
//   final String currentUserId;
//   final String currentName;
//   final String currentImage;
//   final String generalId;
//   final String generalName;
//   final String generalImage;

//   const GroupDate(
//       {required this.currentUserId,
//       required this.currentName,
//       required this.currentImage,
//       required this.generalId,
//       required this.generalName,
//       required this.generalImage,
//       super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blueAccent,
//         title: ListTile(
//           leading: CircleAvatar(
//             radius: 20.0,
//             backgroundImage: NetworkImage(generalImage),
//           ),
//           title: Text(generalName, style: TextStyle(color: Colors.white)),
//         ),
//       ),
//       body: Column(
//         children: [
//           StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('general')
//                   .doc(generalId)
//                   .collection('chats')
//                   .snapshots(),
//               builder: (context, AsyncSnapshot snapshot) {
//                 if (snapshot.hasData) {
//                   if (snapshot.data.docs.length < 1) {
//                     return Center(
//                       child: Text("Скажите что нибудь"),
//                     );
//                   }
//                   return ListView.builder(
//                       itemCount: snapshot.data.docs.length,
//                       reverse: true,
//                       physics: BouncingScrollPhysics(),
//                       itemBuilder: (context, index) {
//                       return Text("data");
//                       });
//                 }
//                 return Center(child: CircularProgressIndicator());
//               }),
//           GeneralPage(
//               currentUserId: currentUserId,
//               currentName: currentName,
//               currentImage: currentImage,
//               generalId: generalId,
//               generalName: generalName,
//               generalImage: generalImage),
//         ],
//       ),
//     );
//   }
// }

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
    int count = 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: ListTile(
          leading: CircleAvatar(
            radius: 20.0,
            backgroundImage: NetworkImage(generalImage),
          ),
          title: Text(generalName, style: TextStyle(color: Colors.white)),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
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

                    // return GroupedListView(elements: snapshot.data.docs.length, groupBy: (element))
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        reverse: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          bool isMe = snapshot.data.docs[index]['senderId'] ==
                              currentUserId;
                          Timestamp date = snapshot.data.docs[index]['date'];
                          var dateFormat = new DateFormat('dd MMMM yyyy');
                          String sendDate2 = dateFormat.format(date.toDate());
                          String name = snapshot.data.docs[index]['senderName'];
                          // List<String> sendDate = [];

                          // for (int i = snapshot.data.docs.length - 1;
                          //     i >= 0;
                          //     i--) {
                          //   Timestamp date1 = snapshot.data.docs[i]['date'];
                          //   String sendDate1 =
                          //       dateFormat.format(date1.toDate());
                          //   sendDate.add(sendDate1);
                          // }

                          // List distinctIds = sendDate.toSet().toList();
                          
                          
                          // for (int i = 0; i < sendDate.length; i++) {
                          //   String dateBlack = sendDate[i];
                          //   if (sendDate2 != dateBlack) {
                          //     Column(
                          //       children: [
                          //         Text(sendDate2),
                          //         // generalSingleMessage(
                          //         //     message: snapshot.data.docs[index]
                          //         //         ['message'],
                          //         //     isMe: isMe,
                          //         //     timeMessage: date,
                          //         //     name: name,
                          //         //     generalId: generalId)
                          //       ],
                          //     );
                          //   }
                          //   datedd = dateBlack;
                          //   return generalSingleMessage(
                          //       message: snapshot.data.docs[i]['message'],
                          //       isMe: isMe,
                          //       timeMessage: date,
                          //       name: name,
                          //       generalId: generalId);
                          // }

                          return Column(
                            children: [
                              Text(sendDate2),
                               generalSingleMessage(
                                message: snapshot.data.docs[index]['message'],
                                isMe: isMe,
                                timeMessage: date,
                                name: name,
                                generalId: generalId)
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
    );
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
    String message = _controller.text;
    _controller.clear();
    await FirebaseFirestore.instance
        .collection('general')
        .doc(generalId)
        .collection("chats")
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
