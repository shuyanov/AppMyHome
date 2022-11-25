import '../Data/users.dart';
import '/Chats/Models/User.dart';
import '/Chats/Data/Admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// base.addUsers(
//     myId: row.colAt(1).toString(),
//     myUserEmail: adminEmail,
//     myUserName: row.colAt(3).toString(),
//     myUserSurname: row.colAt(4).toString(),
//     myUserMiddle_name: row.colAt(5).toString(),
//     myCodve: row.colAt(7).toString(),
//     myStatus: row.colAt(8).toString(),
//     myPersonalCheck: row.colAt(9).toString(),
//     myNumberPhone: row.colAt(10).toString(),
//     myUrlAvatar: '');
// Map<String, dynamic> json = {};

class baseAPI {
  static Future updateUser({
    required String userEmail,
    required String userSurname,
    required String userName,
    required String userMiddle_name,
    //required String urlAvatar,
  }) async {
    final docUser =
    await FirebaseFirestore.instance.collection('users').doc(myId);
    docUser.update({
      'email': userEmail,
      'surname': userSurname,
      'middle_name': userMiddle_name,
      'name': userName
    });
  }

  static Future addUsers({
    required String id,
    required String userEmail,
    required String userSurname,
    required String userName,
    required String userMiddle_name,
    required String code,
    required String status,
    required String personalCheck,
    required String numberPhone,
    required String urlAvatar,
  }) async {
    // final docUsers = await FirebaseFirestore.instance.collection('users');
    final docUser =
    await FirebaseFirestore.instance.collection('users').doc(id);
    final allUsers = await docUser.get();
    if (allUsers.id != myId) {
      final user = User(
          idUser: docUser.id,
          email: userEmail,
          name: userName,
          surname: userSurname,
          middle_name: userMiddle_name,
          code: code,
          status: status,
          personalCheck: personalCheck,
          numberPhone: numberPhone,
          urlAvatar: urlAvatar);

      myId = docUser.id;
      myUserEmail = userEmail;
      myUserSurname = userSurname;
      myUserName = userName;
      myUserMiddle_name = userMiddle_name;
      myCode = code;
      myStatus = status;
      myPersonalCheck = personalCheck;
      myNumberPhone = numberPhone;
      myUrlAvatar = urlAvatar;

      await docUser.set(user.toJson());
      print('ADD: ${docUser.set(user.toJson())}');
    }
    // final user = {
    //   'userEmail': userEmail,
    //   'userName': userName,
    //   'userSurname': userSurname,
    //   'userMiddle_name': userMiddle_name,
    //   'code': code,
    //   'status': status,
    //   'personalCheck': personalCheck,
    //   'numberPhone': numberPhone,
    //   'urlAvatar': urlAvatar,
    // };

    //   // final userDoc = docUser.doc(idUser);
    //   // idUser = userDoc.id;
    //   // final newUser = user.copyWith(idUser: userDoc.id);
    //   // await userDoc.set(newUser.toJson());
    // }
  }

  // static Future addUsers(List<User> users) async {
  //   String? idUser;
  //   final docUser = await FirebaseFirestore.instance.collection('users');
  //   final allUsers = await docUser.get();
  //   if (allUsers.size != 0) {
  //     return;
  //   } else {
  //     for (final user in users) {
  //       final userDoc = docUser.doc(idUser);
  //       idUser = userDoc.id;
  //       final newUser = user.copyWith(idUser: userDoc.id);
  //       await userDoc.set(newUser.toJson());
  //     }
  //   }
  // }

  static Stream<List<User>> readUsers() =>
      FirebaseFirestore.instance
          .collection('users')
          .snapshots()
          .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

  //Future<User?> readUser() async {
    // static Future<User?> readUser() async {
    //   final docUser =
    //       await FirebaseFirestore.instance.collection('users').doc(myId);
    //   final snapshot = await docUser.get();
    //   if (snapshot.exists) {
    //     print ('DATA >>> ${User.fromJson(snapshot.data()!).urlAvatar}');
    //     return User.fromJson(snapshot.data()!);
    //   }
    // }

     static Future<User?> readAvatar() async {
      final docUser =
      await FirebaseFirestore.instance.collection('users').doc(myId);
      final snapshot = await docUser.get();
      if (snapshot.exists) {
        // print ('DATA >>> ${User.fromJson(snapshot.data()!).urlAvatar}');
        myUrlAvatar = User
            .fromJson(snapshot.data()!)
            .urlAvatar;
        return User.fromJson(snapshot.data()!);
      }
    }
  }