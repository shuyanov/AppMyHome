import 'package:flutter/rendering.dart';

import 'Chats/Data/Admin.dart';
import 'Chats/Models/User.dart';
import 'Chats/OneChats.dart';
import 'Chats/Pages/ChatPage.dart';
import 'GeneralChats/Data/General.dart';
import 'GeneralChats/Pages/GeneralPage.dart';
import 'package:flutter/material.dart';
import 'Styles/Colors.dart';

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
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/chat/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: Column(
                children: [
                Container(
                  height: size.height * 0.2,               
                    padding: EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "ЧАТЫ",
                        style: TextStyle(fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )),                    
    
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50)),
                          image: DecorationImage(
                            image: AssetImage('assets/chat/resource.png'),
                            fit: BoxFit.cover,
                          ),  
                        ),  
                        child: Container(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                                  child: ListTile(
                                      // Общий чат
                                      contentPadding: EdgeInsets.all(10),
                                      leading: Image.asset('assets/chat/resource28.png'),
                                      title: Text(name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: greyText),),
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
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                                  child: ListTile(
                                      // Подъезд №2
                                      contentPadding: EdgeInsets.all(10),
                                      leading: Image.asset('assets/chat/resource28.png'),
                                      title: Text(name2, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: greyText),),
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
                                Card(elevation: 5,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                                  child: ListTile(
                                      contentPadding: EdgeInsets.all(10),
                                      // "УК"
                                      leading: Image.asset('assets/chat/resource28.png'),
                                      title: Text(name3, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: greyText),),
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
                                Card(elevation: 5,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                                  child: ListTile(
                                      // Личные сообщения
                                      contentPadding: EdgeInsets.all(10),
                                      leading: Image.asset('assets/chat/resource29.png', height: 50, width: 50,),
                                      title: Text('Личные сообщения', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: greyText),),
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => const OneChats()));
                                      }),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      
                    ),
                  ),              
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
