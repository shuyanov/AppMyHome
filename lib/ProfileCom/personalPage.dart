import 'package:flutter/material.dart';

import '../Model/User.dart';
import '../Styles/Colors.dart';
import 'Api/api.dart';
import 'historyPage.dart';
import 'myTasks.dart';
import 'requestsPage.dart';
import 'settings.dart';

int _currentIndex = 0;

class PersonalPage extends StatefulWidget {
  final User user;
  const PersonalPage({required this.user});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}


class _PersonalPageState extends State<PersonalPage> {
  @override
  void initState() {
    // fetch();
    GetRequest();
    GetRequestHistory();
    GetRequestInWork();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
List<Widget> _pages = [
  RequestsPage(user: widget.user,),
  myTasks(),
  historyPage(),
  settingsPage(),
];
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: 
        // RefreshIndicator(
        //   color: purpleColor,
        //   onRefresh: () async {
        //     GetRequest();
        //     GetRequestHistory();
        //     GetRequestInWork();
        //     return Future.delayed(Duration(seconds: 3), () {});
        //   },
        //   child: 
          // ScrollConfiguration(
          //   behavior: ScrollBehavior(
          //       // androidOverscrollIndicator: AndroidOverscrollIndicator.glow
          //       ),
          //   child: GlowingOverscrollIndicator(
          //     axisDirection: AxisDirection.down,
          //     color: Colors.transparent.withOpacity(0.05),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: 
                SizedBox(
                    height: size.height * 0.9001,
                    // child: Expanded(
                    child: _pages.elementAt(_currentIndex)),
                ),
              // ),
            
          // ),
        // ),
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
