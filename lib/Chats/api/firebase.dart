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
  //     myCode: row.colAt(7).toString(),
  //     myStatus: row.colAt(8).toString(),
  //     myPersonalCheck: row.colAt(9).toString(),
  //     myNumberPhone: row.colAt(10).toString(),
  //     myUrlAvatar: '');
class base {
  static Future addUsers({
    required String myId,
    required String myUserEmail,
    required String myUserSurname,
    required String myUserName,
    required String myUserMiddle_name,
    required String myCode,
    required String myStatus,
    required String myPersonalCheck,
    required String myNumberPhone,
    required String myUrlAvatar,
  }) async {
    final docUsers = await FirebaseFirestore.instance.collection('users');
    final allUsers = await docUsers.get();
    print ("ID >>>>> ${docUsers.doc(myId)}");
    // if (docUsers.id == myId) {
    //   return;
    // } else {
      final docUser = await FirebaseFirestore.instance.collection('users').doc(myId);
      final json = {
        'myUserEmail': myUserEmail,
        'myUserName': myUserName,
        'myUserSurname': myUserSurname,
        'myUserMiddle_name': myUserMiddle_name,
        'myCode': myCode,
        'myStatus': myStatus,
        'myPersonalCheck': myPersonalCheck,
        'myNumberPhone': myNumberPhone,
        'myUrlAvatar': myUrlAvatar,
      };
      await docUser.set(json);
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

  static Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

  Future<User?> readUser() async {
    final docUser =
        await FirebaseFirestore.instance.collection('users').doc(myId);
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      return User.fromJson(snapshot.data()!);
    }
    print(docUser.toString());
  }
}
