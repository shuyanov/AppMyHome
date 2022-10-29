import 'package:command_flutter/Chats/Chats.dart';
import 'package:command_flutter/ScrolLent/Filling.dart';
import 'package:command_flutter/Chats/Pages/SearchPage.dart';
import 'package:command_flutter/Pages/EditProfilePage.dart';
import 'package:command_flutter/Pages/ProfilePage.dart';
import 'package:command_flutter/Widget/Bar/Profile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  static const _navigationBarItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
      backgroundColor: Colors.blueAccent,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.message),
      label: 'Message',
      backgroundColor: Colors.blue,
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
        backgroundColor: Colors.blue,
    ),
  ];
  static const List<Widget> _pages = <Widget>[
    Filing(),
    Chats(),
    EditProfilePage(),
  ];

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
                    appBar: AppBar(
                      title: const Text('Уведомления'),
                      backgroundColor: Colors.blueAccent,
                    ),
                  );
                }
            ));
          },
        ),
          /*actions: [
      IconButton(
      icon: const Icon(Icons.add),
      tooltip: 'Edit',
      onPressed: () {
        Navigator.push(context, MaterialPageRoute<void>(
            builder: (BuildContext){
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Edit'),
                  backgroundColor: Colors.blueAccent,
                ),
              );
            }
        ));
      },
    )
        ],*/
      ),
      body: Center(
        child: _pages.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Новости',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: 'Чаты',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Личный Кабинет',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}