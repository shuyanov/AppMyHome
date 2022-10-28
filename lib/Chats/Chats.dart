import 'package:command_flutter/Chats/Data/Admin.dart';
import 'package:command_flutter/Chats/Models/User.dart';
import 'package:command_flutter/Chats/Pages/ChatPage.dart';
import 'package:command_flutter/Chats/api/firebase.dart';
import 'package:flutter/material.dart';


class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Сообщения"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return Container(
                    child: Text("В разработке"),
                  ); //SearchPage();
                }),
              );
            },
            icon: Icon(Icons.search),
            splashRadius: 20,
          ),
        ],
      ),
      body:
          StreamBuilder<List<User>>(
              stream: base.readUsers(),
              builder: (context, snapshot) {
                final users = snapshot.data!;
                return ListView(
                  children: users.map(buildUser).toList(),
                );
              }),
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
            friendDescription: user.name,
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
