import 'dart:io';

import 'package:command_flutter/Chats/Data/Admin.dart';
import 'package:command_flutter/Chats/Models/User.dart';
import 'package:command_flutter/Chats/Pages/ChatPage.dart';
import 'package:command_flutter/Chats/api/firebase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadPage();
  }

  _loadPage() async {
    Future.delayed(const Duration(milliseconds: 500), () {

      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading)
      return Center(
        child: CircularProgressIndicator(),
      );
    else
      return Scaffold(
          body: SafeArea(
        child: StreamBuilder<List<User>>(
            stream: base.readUsers(),
            builder: (context, snapshot) {
              final users = snapshot.data!;
              return ListView(
                children: users.map(buildUser).toList(),
              );
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
            builder: (_) => ChatPage(
                currentUserId: myId,
                friendId: user.idUser!,
                friendName: user.name,
                friendDescription: user.description,
                friendImage: user.urlAvatar)));
      },
    );
  }
}
