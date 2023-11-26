import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../Chats/Data/Admin.dart';

Future addImage(File imageFile) async {
  String fileName = Uuid().v1();
  int status = 1;
  var img = FirebaseStorage.instance
      .ref()
      .child('profiles')
      .child('${fileName}.png');
  var uploadTask = await img.putFile(imageFile).catchError((error) async {
    print("Ошибка");
        await FirebaseFirestore.instance
        .collection('users')
        .doc(myId)
        .update({'urlAvatar': '0'});
      FirebaseStorage.instance
      .ref()
      .child('profiles')
      .child('${fileName}.png').delete();
    status = 0;
  });
  if (status == 1) {
    String imageUrl = await uploadTask.ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(myId)
        .update({'urlAvatar': imageUrl});

    print("Изображение профиля: $imageUrl");
  myUrlAvatar = imageUrl;
  }
}
