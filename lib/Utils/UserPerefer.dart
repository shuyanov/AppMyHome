import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:crypto/crypto.dart';

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
        required this.code,
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

class UsersedTest{
  final String login;
  final String password;
  final String surname;
  final String name;
  final String middle_name;
  final String code;
  final String id;
  final String stateAdmin;
  final String personalCheck;
  final String numberPhone;


  UsersedTest(
      { required this.login,
        required this.password,
        required this.surname,
        required this.name,
        required this.middle_name,
        required this.code,
        required this.id,
        required this.stateAdmin,
        required this.personalCheck,
        required this.numberPhone,
      });

  factory UsersedTest.fromJson(Map<String, dynamic> json)=>
      UsersedTest(
          login: json['login'],
          password:json['password'],
          surname: json['surname'],
          name: json['name'],
          middle_name: json['middle_name'],
          code: json['code'],
          id: json['id'],
          stateAdmin: json['stateAdmin'],
          personalCheck: json['personalCheck'],
          numberPhone: json['numberPhone']
      );
  Map<String, dynamic> toJson()=>{
    'login': login,
    'password':password,
    'surname': surname,
    'name': name,
    'middle_name': middle_name,
    'code': code,
    'id': id,
    'stateAdmin': stateAdmin,
    'personalCheck': personalCheck,
    'numberPhone': numberPhone
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

void ViewJsonTest() async {

  final directory = await pathProvider.getApplicationSupportDirectory();
  final fileDirectory = directory.path + '/datasTest.json';
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

void getUserTest() async {

  final directory = await pathProvider.getApplicationSupportDirectory();
  final fileDirectory = directory.path + '/datasTest.json';
  final file = File(fileDirectory);

  final json = jsonDecode(await file.readAsString());

  print(json);
  Usersed nikita = Usersed.fromJson(json['user']);
  print("code = ${nikita.code}");
}


void PushToJsonTest(String login, String password, String surname, String name, String middle_name, String code, String id, String stateAdmin, String personalCheck, String numberPhone) async {

  final directory = await pathProvider.getApplicationSupportDirectory();
  final fileDirectory = directory.path + '/datasTest.json';
  final file = File(fileDirectory);
  await file.writeAsString('{\"user\": {\"login\" : \"$login\"\,\"password\" : \"$password\",\"surname\" : \"$surname\",\"name\" : \"$name\",\"middle_name\" : \"$middle_name\",\"code\" : \"$code\",\"id\" : \"$id\",\"stateAdmin\" : \"$stateAdmin\",\"personalCheck\" : \"$personalCheck\",\"numberPhone\" : \"$numberPhone\"}}');
  final res = await file.readAsString();
  print("created json: $res");

}

String encoding(String value){
  var byte = utf8.encode(value);

  var digest = sha256.convert(byte);
  return digest.toString();
}

void PushToJson(String login, String password, String surname, String name, String middle_name, String code) async {

  final directory = await pathProvider.getApplicationSupportDirectory();
  final fileDirectory = directory.path + '/datas.json';
  final file = File(fileDirectory);
  await file.writeAsString('{\"user\": {\"login\" : \"$login.\"\,\"password\" : \"$password\",\"surname\" : \"$surname\",\"name\" : \"$name\",\"middle_name\" : \"$middle_name\",\"code\" : \"$code\"}}');
  final res = await file.readAsString();
  print("created json: $res");

}
