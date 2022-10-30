import 'dart:convert';
import 'dart:io';
import 'package:command_flutter/Model/User.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;


class UserPereferences{
  static const myUser = User(
      imagePath: "https://www.imagensempng.com.br/wp-content/uploads/2021/08/Icone-usuario-Png.png",
      name: "Max Shuyanov",
      email: "mks@mail.ru",
      about: "one two thre",
      numberPhone:  "898000000"
  );
}

class Usersed{
  final String login;
  final String password;
  final String surname;
  final String name;
  final String middle_name;
  final String code;

  Usersed(
      { required this.login,
        required this.password,
        required this.surname,
        required this.name,
        required this.middle_name,
        required this.code
      });

  factory Usersed.fromJson(Map<String, dynamic> json)=>
      Usersed(
          login: json['login'],
          password:json['password'],
          surname: json['surname'],
          name: json['name'],
          middle_name: json['middle_name'],
          code: json['code']
      );
  Map<String, dynamic> toJson()=>{
    'login': login,
    'password':password,
    'surname': surname,
    'name': name,
    'middle_name': middle_name,
    'code': code
  };
}

void ViewJson() async {

  final directory = await pathProvider.getApplicationSupportDirectory();
  final fileDirectory = directory.path + '/datas.json';
  final file = File(fileDirectory);
  print(fileDirectory);
  final isExist = await file.exists();
  print("file found: $isExist");

  final res = await file.readAsString();
  print(res);

}

void getUser() async {

  final directory = await pathProvider.getApplicationSupportDirectory();
  final fileDirectory = directory.path + '/datas.json';
  final file = File(fileDirectory);

  final json = jsonDecode(await file.readAsString());

  print(json);
  Usersed nikita = Usersed.fromJson(json['user']);
  print("code = ${nikita.code}");

}

void PushToJson(String login, String password, String surname, String name, String middle_name, String code) async {

  final directory = await pathProvider.getApplicationSupportDirectory();
  final fileDirectory = directory.path + '/datas.json';
  final file = File(fileDirectory);

  await file.writeAsString('{\"user\": {\"login\" : \"$login\"\,\"password\" : \"$password\",\"surname\" : \"$surname\",\"name\" : \"$name\",\"middle_name\" : \"$middle_name\",\"code\" : \"$code\"}}');

  final res = await file.readAsString();
  print(res);

}
