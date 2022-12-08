import 'package:command_flutter/Chats/api/firebase.dart';

import 'Chats/Data/Admin.dart';

void addUser(
  String Id,
  String UserEmail,
  String UserSurname,
  String UserName,
  String UserMiddle_name,
  String Code,
  String Status,
  String PersonalCheck,
  String NumberPhone,
) async {
  baseAPI.addUsers(
      id: Id,
      userEmail: UserEmail,
      userSurname: UserSurname,
      userName: UserName,
      userMiddle_name: UserMiddle_name,
      code: Code,
      status: Status,
      personalCheck: PersonalCheck,
      numberPhone: NumberPhone,);

      // myUserEmail = UserEmail;
      // myUserSurname = UserSurname;
      // myUserName = UserName;
      // myUserMiddle_name = UserMiddle_name;
      // myCode = Code;
      // myStatus = Status;
      // myPersonalCheck = PersonalCheck;
      // myNumberPhone = NumberPhone;
      // myUrlAvatar = '0';
}
