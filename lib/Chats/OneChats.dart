import 'package:command_flutter/Chats/Data/Admin.dart';
import 'package:command_flutter/Chats/Models/User.dart';
import 'package:command_flutter/Chats/Pages/ChatPage.dart';
import 'package:command_flutter/Chats/Pages/SearchUserPage.dart';
import 'package:command_flutter/Chats/api/firebase.dart';
import 'package:command_flutter/GeneralChats/Data/General.dart';
import 'package:flutter/material.dart';

import '../GeneralChats/Pages/GeneralPage.dart';

class OneChats extends StatefulWidget {
  const OneChats({super.key});

  @override
  State<OneChats> createState() => _OneChatsState();
}

class _OneChatsState extends State<OneChats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Личные сообщения'),
          backgroundColor: Colors.blueAccent,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return SearchUserPage();
                  }),
                );
              },
              icon: Icon(Icons.search),
              splashRadius: 20,
            ),
          ],
        ),
        body: SafeArea(
          child: StreamBuilder<List<User>>(
              stream: base.readUsers(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  default:
                    if (snapshot.hasError) {
                      print(snapshot.error);
                      return buildText('Что-то пошло не так, попробуйте позже');
                    } else {
                      final users = snapshot.data!;

                      if (users.isEmpty) {
                        return buildText('Нет такого пользователя');
                      } else
                        // ignore: curly_braces_in_flow_control_structures
                        return ListView(
                          children: users.map(buildUser).toList(),
                        );
                    }
                }
              }),
        ));
  }

  Widget buildUser(User user) {
    if (user.idUser == myId)
      return Container();
    else
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
