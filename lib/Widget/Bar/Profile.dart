import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 80,
        child: CircleAvatar(
        backgroundColor: Colors.blue,
        radius: 40,
        child: const Text('AH',style: TextStyle(fontSize: 36),),
        )
    );
  }
}
