import '../Styles/Colors.dart';
import '/Chats/Data/Admin.dart';
import '/Chats/Models/User.dart';
import '/Chats/Pages/ChatPage.dart';
import '/Chats/Pages/SearchUserPage.dart';
import '/Chats/api/firebase.dart';
import 'package:flutter/material.dart';

class OneChats extends StatefulWidget {
  const OneChats({super.key});

  @override
  State<OneChats> createState() => _OneChatsState();
}

class _OneChatsState extends State<OneChats> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/chat/backgroundUsers.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            backgroundColor: purpleColor,
            title: Text('Личные сообщения'),
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
                stream: baseAPI.readUsers(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                          child: CircularProgressIndicator(
                        color: purpleColor,
                      ));
                    default:
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return buildText(
                            'Что-то пошло не так, попробуйте позже зайти');
                      } else if (snapshot.hasData) {
                        final users = snapshot.data!;

                        if (users.isEmpty) {
                          return buildText('Произошла ошибка');
                        }
                        return ScrollConfiguration(
                            behavior: ScrollBehavior(),
                            child: GlowingOverscrollIndicator(
                              axisDirection: AxisDirection.down,
                              color: purpleColor,
                              child: ListView(
                                children: users.map(buildUser).toList(),
                              ),
                            ));
                      } else {
                        return Center(
                            child: CircularProgressIndicator(
                          color: purpleColor,
                        ));
                      }
                  }
                }),
          )),
    );
  }

  Widget buildUser(User user) {
    if (user.idUser == myId)
      return Container();
    else
      return Card(
        child: ListTile(
          contentPadding: EdgeInsets.all(10),
          leading: Image.asset('assets/chat/resource29.png'),
          title: Text(
            user.name,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: greyText),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChatPage(
                    currentUserId: myId,
                    friendId: user.idUser,
                    friendName: user.name,
                    friendSurname: user.surname,
                    friendMiddle_name: user.middle_name)));
          },
        ),
      );
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      );
}
