import 'package:flutter/material.dart';


AppBar buildAppBar(BuildContext context) {
  return AppBar(
      leading: BackButton(),
      backgroundColor: Colors.tealAccent,
      elevation: 0,
  );
}