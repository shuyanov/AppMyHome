
import 'package:MyAppHome/Chats/api/firebase.dart';
import 'package:MyAppHome/Data/usersData.dart';
import 'package:MyAppHome/Model/User.dart';
import 'package:MyAppHome/addUser.dart';
import 'package:flutter/material.dart';

import 'Chats.dart';
import 'Pages/ProfilePage.dart';
import 'Payment/paymentPage.dart';
import 'PushNotifications/PushNotic.dart';
import 'ScrolLent/Filling.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    addUser(widget.user.id, widget.user.email, '', widget.user.name, '', '', '', '',
            widget.user.numberPhone);
    checkForNotification();
  }

  int _currentIndex = 0;

  // static const _navigationBarItems = <BottomNavigationBarItem>[
  //   BottomNavigationBarItem(
  //       icon: Icon(Icons.home),
  //       label: 'Home',
  //       backgroundColor: Color.fromARGB(255, 124, 97, 242)),
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.message),
  //     label: 'Payment',
  //     // backgroundColor: Color.fromARGB(255, 124, 97, 242)
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.message),
  //     label: 'Message',
  //     // backgroundColor: Colors.blue,
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.person),
  //     label: 'Profile',
  //     backgroundColor: Colors.blue,
  //   ),
  // ];

////
  @override
  Widget build(BuildContext context) {
  List<Widget> _pages = <Widget>[
    Filing(user: widget.user),
    PaymentPage(),
    Chats(user: widget.user),
    ProfileePage(user: widget.user,),
  ];
    return SafeArea(
      child: Scaffold(

        // appBar: AppBar(
        //   actions: [
        //     IconButton(
        //       onPressed: () {
        //         Navigator.of(context).push(
        //           MaterialPageRoute(builder: (context) {
        //             return SearchPage();
        //           }),
        //         );
        //       },
        //       icon: Icon(Icons.search),
        //       splashRadius: 20,
        //     ),
        //   ],
        //   backgroundColor: Color.fromARGB(255, 124, 97, 242),
        //   leading: IconButton(
        //     icon: const Icon(Icons.add_alert_rounded),
        //     tooltip: 'Уведомления',
        //     onPressed: () {
        //       showNotification(
        //           "Заголовок", "Описание"); // Проверка работы уведомления
        //     },
        //     /* () {
        //       Navigator.push(context, MaterialPageRoute<void>(
        //           builder: (BuildContext){
        //             return Scaffold(
        //               backgroundColor: Color.fromARGB( 200, 105, 193, 238),
        //               appBar: AppBar(
        //                 title: const Text('Уведомления'),
        //                 backgroundColor: Colors.blueAccent,
        //               ),
        //               body: Center(
        //                 child: Text('В разработке', style: TextStyle(fontSize: 45, fontFamily: 'Arial'),),
        //               ),
        //             );
        //           }
        //       ));
        //     }, */
        //   ),
        // ),

        body: Center(

          child: _pages.elementAt(_currentIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.newspaper),
              label: 'Новости',
              backgroundColor: Color.fromARGB(255, 124, 97, 242),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              label: 'Оплата',
              backgroundColor: Color.fromARGB(255, 124, 97, 242),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_outlined),
              label: 'Чаты',
              backgroundColor: Color.fromARGB(255, 124, 97, 242),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Личный Кабинет',
              backgroundColor: Color.fromARGB(255, 124, 97, 242),
            ),
          ],
          currentIndex: _currentIndex,
          selectedItemColor: Colors.amber[800],
          // backgroundColor: Color.fromARGB(255, 124, 97, 242),
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
