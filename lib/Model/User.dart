import 'package:command_flutter/Chats/Models/User.dart';
import 'package:flutter/cupertino.dart';

class User{
  final String imagePath;
  final String name;
  final String email;
  final String about;
  final String numberPhone;

  const User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.about,
    required this.numberPhone,
  });
}
