import 'package:command_flutter/Chats/api/firebase.dart';

void addUser(
  String myId,
  String myUserEmail,
  String myUserSurname,
  String myUserName,
  String myUserMiddle_name,
  String myCode,
  String myStatus,
  String myPersonalCheck,
  String myNumberPhone,
) async {
  base.addUsers(
      myId: myId,
      myUserEmail: myUserEmail,
      myUserSurname: myUserSurname,
      myUserName: myUserName,
      myUserMiddle_name: myUserMiddle_name,
      myCode: myCode,
      myStatus: myStatus,
      myPersonalCheck: myPersonalCheck,
      myNumberPhone: myNumberPhone,
      myUrlAvatar: '');
}
