import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:command_flutter/Chats/Data/Admin.dart';
import 'package:command_flutter/Chats/Models/User.dart';

class base {
  static Future addUsers(List<User> users) async {
    String? idUser;
    final docUser = await FirebaseFirestore.instance.collection('users');
    final allUsers = await docUser.get();
    if (allUsers.size != 0) {
      return;
    } else {
      for (final user in users) {
        final userDoc = docUser.doc();
        idUser = userDoc.id;
        final newUser = user.copyWith(idUser: userDoc.id);
        await userDoc.set(newUser.toJson());
      }
    }
  }

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