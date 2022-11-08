import 'Chats/Data/Admin.dart';
import 'Chats/Models/User.dart';
import 'Chats/OneChats.dart';
import 'Chats/Pages/ChatPage.dart';
import 'GeneralChats/Data/General.dart';
import 'GeneralChats/Pages/GeneralPage.dart';
import 'package:flutter/material.dart';

import 'PushNotifications/PushNotic.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {


  String name = 'Общий чат';
  String name2 = 'Подъезд №2';
  String name3 = '\"УК\"';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Column(children: [
          Stack(children: [
            Positioned(
              child: Container(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Чаты",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    )),
                height: size.height * 0.3,
                width: size.height,
                color: Colors.blueAccent,
              ),
            ),
            Positioned(
                child: Container(
              margin: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  //vertical: size.height - size.height * 0.740
                  top: size.height - size.height * 0.750
                  // vertical: size.height * 0.2
                  ),
              child: Column(children: [
                Card(
                  child: ListTile(
                      // Общий чат
                      leading: CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(generalUrlAvatar),
                      ),
                      title: Text(name),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => GeneralPage(
                                currentUserId: myId,
                                currentName: myUsername,
                                currentImage: myUrlAvatar,
                                generalId: idGeneral,
                                generalName: name,
                                generalImage: generalUrlAvatar)));
                      }),
                ),
                Card(
                  child: ListTile(
                      //Подъезд №2
                      leading: CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(generalUrlAvatar),
                      ),
                      title: Text(name2),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => GeneralPage(
                                currentUserId: myId,
                                currentName: myUsername,
                                currentImage: myUrlAvatar,
                                generalId: idGeneral2,
                                generalName: name2,
                                generalImage: generalUrlAvatar)));
                      }),
                ),
                Card(
                  child: ListTile(
                      // "УК"
                      leading: CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(generalUrlAvatar),
                      ),
                      title: Text(name3),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => GeneralPage(
                                currentUserId: myId,
                                currentName: myUsername,
                                currentImage: myUrlAvatar,
                                generalId: idGeneral3,
                                generalName: name3,
                                generalImage: generalUrlAvatar)));
                      }),
                ),
                Card(
                  child: ListTile(
                      leading: CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(myUrlAvatar),
                      ),
                      title: Text('Личные сообщения'),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const OneChats()));
                      }),
                ),
              ]),
            )),
          ]),
        ]),
      ),
    );
  }

  Widget buildUser(User user) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20.0,
        backgroundImage: NetworkImage(user.urlAvatar),
      ),
      title: Text(user.name),
      subtitle: Text(user.description),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatPage(
                currentUserId: myId,
                friendId: user.idUser!,
                friendName: user.name,
                friendDescription: user.description,
                friendImage: user.urlAvatar)));
      },
    );
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      );
}
