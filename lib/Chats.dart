import 'Chats/Data/Admin.dart';
import 'Chats/Models/User.dart';
import 'Chats/OneChats.dart';
import 'Chats/Pages/ChatPage.dart';
import 'GeneralChats/Data/General.dart';
import 'GeneralChats/Pages/GeneralPage.dart';
import 'package:flutter/material.dart';

import 'PushNotifications/PushNotic.dart';
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
          resizeToAvoidBottomInset: true,
          body: Column(
                children: [
                
                // Stack(children: [
                // Positioned(
                //   child: Container(
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
                // height: size.height * 0.3,
                // width: size.height,
                // color: Colors.blueAccent,
                // ),
                // ),
                // Positioned(
                //     child: Container(
                //   margin: EdgeInsets.only(
                //       left: 15,
                //       right: 15,
                //       //vertical: size.height - size.height * 0.740
                //       top: size.height - size.height * 0.750
                //       // vertical: size.height * 0.2
                //       ),                      
    
                    Expanded(
                      child: Container(
                        // alignmen/t: Alignment.,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50)),
                          image: DecorationImage(
                            image: AssetImage('assets/chat/resource.png'),
                            fit: BoxFit.cover,
                          ),  
                        ),  
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Column(children: [
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
                                  leading: Image.asset('assets/chat/resource29.png'),
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
