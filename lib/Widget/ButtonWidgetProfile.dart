import 'package:flutter/material.dart';

class ButtonWidgetProfile extends StatelessWidget {
  final VoidCallback onClicked;
  // final IconData icon;
  final String imagees;

  const ButtonWidgetProfile({
    Key? key,
    // required this.icon,
    required this.onClicked,
    required this.imagees
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
        onPrimary: Colors.black,
          backgroundColor: Color.fromARGB(200, 227, 228, 251)
      ),
      onPressed: onClicked,
      child: Stack(
        children: [
          Center(
            child:  Image.asset(imagees),
            ),
        ],
      ),
  );
      // child: Text(text));
}