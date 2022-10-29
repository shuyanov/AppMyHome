import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
}
