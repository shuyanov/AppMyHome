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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
           child: Column(
             children: [
              ListTile(
                  leading: CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(generalUrlAvatar),
                  ),
                  title: Text('Общий чат'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GeneralChatsPage()
                        
                        // GeneralPage(
                        //     currentUserId: myId,
                        //     friendId: idGeneral,
                        //     friendName: generalName,
                        //     friendImage: generalUrlAvatar)
                            ));
               }),
               ListTile(
                  leading: CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(myUrlAvatar),
                  ),
                  title: Text('Личные сообщения'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OneChats(),));
               }),
             ],
           ), 
    ));
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
