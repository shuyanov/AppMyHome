import 'package:command_flutter/Chats/Data/Admin.dart';
import 'package:command_flutter/GeneralChats/Data/General.dart';
import 'package:command_flutter/GeneralChats/Pages/GeneralPage.dart';
import 'package:flutter/material.dart';

class GeneralChatsPage extends StatefulWidget {
  const GeneralChatsPage({super.key});

  @override
  State<GeneralChatsPage> createState() => _GeneralChatsPageState();
}

class _GeneralChatsPageState extends State<GeneralChatsPage> {
  String name1 = 'Беседа для всех';
  String name2 = 'Дом';
  String name3 = 'Подъезд';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blueAccent, title: Text("Общий чат")),
        body: SafeArea(
          child: Column(
            children: [
              ListTile(
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
              ListTile(
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
              ListTile(
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
            ],
          ),
        ));
  }
}
