import '/Chats/Data/Admin.dart';
import '/Chats/Models/User.dart';
import '/Chats/Pages/ChatPage.dart';
import '/Chats/api/firebase.dart';
import '/Search/SearchPage.dart';
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
          actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return SearchPage();
                }),
              );
            },
            icon: Icon(Icons.search),
            splashRadius: 20,
          ),
        ],
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.add_alert_rounded),
          tooltip: 'Уведомления',
          onPressed: () {
            Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext){
                  return Scaffold(
                    backgroundColor: Color.fromARGB( 200, 105, 193, 238),
                    appBar: AppBar(
                      title: const Text('Уведомления'),
                      backgroundColor: Colors.blueAccent,
                    ),
                    body: Center(
                      child: Text('В разработке', style: TextStyle(fontSize: 45, fontFamily: 'Arial'),),
                    ),
                  );
                }
            ));
          },
        ),
      ),
        backgroundColor: Color.fromARGB( 200, 105, 193, 238),
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
                  return buildText('Something Went Wrong Try later');
                } else {
                  final users = snapshot.data!;

                  if (users.isEmpty) {
                    return buildText('No Users Found');
                  } else
                    return ListView(
                      children: users.map(buildUser).toList(),
                    );
                }
            }
          }),
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
