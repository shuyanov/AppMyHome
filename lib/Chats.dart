import 'package:command_flutter/Chats/Data/Admin.dart';
import 'package:command_flutter/Chats/Models/User.dart';
import 'package:command_flutter/Chats/OneChats.dart';
import 'package:command_flutter/Chats/Pages/ChatPage.dart';
import 'package:command_flutter/GeneralChats/Data/General.dart';
import 'package:command_flutter/GeneralChats/Pages/GeneralChatsPage.dart';
import 'package:command_flutter/GeneralChats/Pages/GeneralPage.dart';
import 'package:flutter/material.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  String name1 = 'Общий чат';
  String name2 = 'Подъезд №2';
  String name3 = '\"УК\"';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(children: [
        // Container(
        //   child: Container(
        //       padding: EdgeInsets.all(10),
        //       child: Text(
        //         "Чаты",
        //         style: TextStyle(fontSize: 30, color: Colors.white),
        //       )),
        //   height: size.height * 0.3,
        //   width: size.height,
        //   color: Colors.blueAccent,
        // ),
        Stack(
          children: [
          Positioned(
              top: 0,
              bottom: size.height * 0.4,
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
            
            child: Align(
              
                alignment: Alignment.bottomCenter,
                child: Container(                  
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 99),
                  child: Column(children: [
                    Card(
                      child: ListTile(
                          leading: CircleAvatar(
                            radius: 20.0,
                            backgroundImage: NetworkImage(generalUrlAvatar),
                          ),
                          title: Text(name1),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => GeneralPage(
                                    currentUserId: myId,
                                    friendId: idGeneral,
                                    friendName: name1,
                                    friendImage: generalUrlAvatar)));
                          }),
                    ),
                    Card(
                      child: ListTile(
                          leading: CircleAvatar(
                            radius: 20.0,
                            backgroundImage: NetworkImage(generalUrlAvatar),
                          ),
                          title: Text(name2),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => GeneralPage(
                                    currentUserId: myId,
                                    friendId: idGeneral,
                                    friendName: name2,
                                    friendImage: generalUrlAvatar)));
                          }),
                    ),
                    Card(
                      child: ListTile(
                          leading: CircleAvatar(
                            radius: 20.0,
                            backgroundImage: NetworkImage(generalUrlAvatar),
                          ),
                          title: Text(name3),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => GeneralPage(
                                    currentUserId: myId,
                                    friendId: idGeneral,
                                    friendName: name3,
                                    friendImage: generalUrlAvatar)));
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
                              builder: (context) => OneChats(),
                            ));
                          }),
                    ),
                  ]),
                )),
          ),
        ]),
      ]),
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
