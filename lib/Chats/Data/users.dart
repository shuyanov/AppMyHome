
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:my_home/Chats/api/firebase.dart';
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
    baseAPI.readUser();
  });
}

// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../Models/User.dart';


//   List <User> users = [
//         User(
//           name: 'user1',
//           description: 'citizen',
//           urlAvatar:
//               'https://avatars.mds.yandex.net/i?id=e3f19061fc32953419cea5c5a238f86c_l-5309503-images-thumbs&n=13',
//           lastMessageTime: Timestamp.now(),
//         ),
//         User(
//           name: 'user2',
//           description: 'citizen',
//           urlAvatar:
//               'https://avatars.mds.yandex.net/i?id=e3f19061fc32953419cea5c5a238f86c_l-5309503-images-thumbs&n=13',
//           lastMessageTime: Timestamp.now(),
//         ),
//         User(
//           name: 'user3',
//           description: 'citizen',
//           urlAvatar:
//               'https://avatars.mds.yandex.net/i?id=e3f19061fc32953419cea5c5a238f86c_l-5309503-images-thumbs&n=13',
//           lastMessageTime: Timestamp.now(),
//         ),
//         User(
//           name: 'user4',
//           description: 'citizen',
//           urlAvatar:
//               'https://avatars.mds.yandex.net/i?id=e3f19061fc32953419cea5c5a238f86c_l-5309503-images-thumbs&n=13',
//           lastMessageTime: Timestamp.now(),
//         ),
//       ];
