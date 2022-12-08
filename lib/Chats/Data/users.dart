import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:command_flutter/Chats/api/firebase.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import '../../Utils/UserPerefer.dart';
import '../../addUser.dart';
import 'Admin.dart';

Future getUsers() async {
  final directory1 = await pathProvider.getApplicationSupportDirectory();
  final fileDirectory1 = directory1.path + '/datas.json';
  final file1 = File(fileDirectory1);
  final json1 = jsonDecode(await file1.readAsString());
  final directory2 = await pathProvider.getApplicationSupportDirectory();
  final fileDirectory2 = directory2.path + '/datasTest.json';
  final file2 = File(fileDirectory2);
  final json2 = jsonDecode(await file2.readAsString());
  print("1 - ${json1}");
  print("2 - ${json2}");
  var nikitaRead = UsersedTest.fromJson(json2['user']);
  var userRead = new Usersed.fromJson(json1['user']);
  Timer(Duration(milliseconds: 50), () {
    myId = nikitaRead.id;
    addUser(nikitaRead.id, userRead.login, userRead.surname, userRead.name, userRead.middle_name,
       userRead.code, nikitaRead.stateAdmin, nikitaRead.personalCheck, nikitaRead.numberPhone);
    baseAPI.readAvatar();
  });
}