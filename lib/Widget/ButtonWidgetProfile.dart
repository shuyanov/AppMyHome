import 'package:flutter/material.dart';

class ButtonWidgetProfile extends StatelessWidget {
  final VoidCallback onClicked;
  final IconData icon;

  const ButtonWidgetProfile({
    Key? key,
    required this.icon,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
        onPrimary: Colors.black,
      ),
      onPressed: onClicked,
      child: Stack(
        children: [
          Center(
            child: Container(
              child:  Icon(icon, size: 42,),
            ),
          )
        ],
      ),
  );
      // child: Text(text));
}