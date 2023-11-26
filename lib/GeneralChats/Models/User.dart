// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:meta/meta.dart';

// class UserField {
//   static final String lastMessageTime = 'lastMessageTime';
// }

// class User {
//   final String? idUser;
//   final String name;
//   final String urlAvatar;
//   final String description;
//   final Timestamp lastMessageTime;

//   const User({
//     this.idUser,
//     required this.name,
//     required this.urlAvatar,
//     required this.description,
//     required this.lastMessageTime,
//   });
//   User copyWith({
//     String? idUser,
//     String? name,
//     String? urlAvatar,
//     String? description,
//     Timestamp? lastMessageTime,
//   }) =>
//       User(
//         idUser: idUser ?? this.idUser,
//         name: name ?? this.name,
//         urlAvatar: urlAvatar ?? this.urlAvatar,
//         description: description ?? this.description,
//         lastMessageTime: lastMessageTime ?? this.lastMessageTime,
//       );

//   Map<String, dynamic> toJson() => {
//         'idUser': idUser,
//         'name': name,
//         'description': description,
//         'urlAvatar': urlAvatar,
//         'lastMessageTime': lastMessageTime,
//       };

//   static User fromJson(Map<String, dynamic> json) =>
//      User(
//       idUser: json['idUser'],
//       name: json['name'],
//       description: json['description'],
//       urlAvatar: json['urlAvatar'],
//       lastMessageTime: json['lastMessageTime'],
//      );
// }
