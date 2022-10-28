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
    Text('home'),
    Text('message'),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.person_pin),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext){
                return Scaffold(
                    appBar: AppBar(
                      title: const Text('Профиль'),
                      backgroundColor: Colors.blueAccent,//Color.fromARGB(255, 210, 227, 246)
                ),
                body: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                        Padding(padding: EdgeInsets.only(top: 30)),
                        CircleAvatar(
                          backgroundImage: AssetImage('image/llll.jpg'),
                          radius: 60,
                        ),
                        Text('Имя пользователя', style: TextStyle(fontSize: 32)),
                        ],
                       )
                      ],
                     ),
                    ),
                  );
                }
            ));
          },
        ),
        actions: <Widget>[
          IconButton(
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
          )
        ],
      ),
      body: Center(
        child: _pages.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _navigationBarItems,
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