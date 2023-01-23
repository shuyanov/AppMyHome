import 'package:command_flutter/ProfileCom/historyPage.dart';
import 'package:command_flutter/ProfileCom/myTasks.dart';
import 'package:command_flutter/ProfileCom/requestsPage.dart';
import 'package:command_flutter/ProfileCom/settings.dart';
import 'package:command_flutter/Styles/Colors.dart';
import 'package:flutter/material.dart';

int _currentIndex = 0;

class personalPage extends StatefulWidget {
  const personalPage({super.key});

  @override
  State<personalPage> createState() => _personalPageState();
}

List<Widget> _pages = [
  requestsPage(),
  myTasks(),
  historyPage(),
  settingsPage(),
];

class _personalPageState extends State<personalPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
            height: size.height, child: _pages.elementAt(_currentIndex)),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.person, color: purpleColor),
                icon: Icon(
                  Icons.person,
                  color: Theme.of(context).iconTheme.color,
                ),
                label: "Личный кабинет"),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.task_rounded, color: purpleColor),
                icon: Icon(Icons.task_rounded,
                    color: Theme.of(context).iconTheme.color),
                label: "Мои заявки"),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.history, color: purpleColor),
                icon: Icon(Icons.history,
                    color: Theme.of(context).iconTheme.color),
                label: "История"),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.settings, color: purpleColor),
                icon: Icon(Icons.settings,
                    color: Theme.of(context).iconTheme.color),
                label: "Настройки"),
          ],
          selectedItemColor: purpleColor,
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
