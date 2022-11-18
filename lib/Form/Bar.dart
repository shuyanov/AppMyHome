import 'package:flutter/material.dart';

import 'ListForm.dart';
import 'form.dart';

class bar extends StatefulWidget {
  const bar({super.key});

  @override
  State<bar> createState() => _barState();
}

class _barState extends State<bar> {
    int _currentIndex = 0;
  static const List<Widget> _pages = <Widget>[
    form(),
    listForm(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Форма для заполнения"),
      ),
      body: Center(
        child: _pages.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Форма',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: 'Список',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.blue,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
