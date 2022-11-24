import 'package:cloud_firestore/cloud_firestore.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class User {
  final String idUser;
  final String email;
  final String name;
  final String surname;
  final String middle_name;
  final String code;
  final String status;
  final String personalCheck;
  final String numberPhone;
  final String urlAvatar;
  final Timestamp lastMessageTime;

  const User({
    required this.idUser,
    required this.email,
    required this.name,
    required this.surname,
    required this.middle_name,
    required this.code,
    required this.status,
    required this.personalCheck,
    required this.numberPhone,
    required this.urlAvatar,
    required this.lastMessageTime,
  });
  User copyWith({
    String? idUser,
    String? email,
    String? name,
    String? surname,
    String? middle_name,
    String? code,
    String? status,
    String? personalCheck,
    String? numberPhone,
    String? urlAvatar,
    Timestamp? lastMessageTime,
  }) =>
      User(
        idUser: idUser ?? this.idUser,
        email: email ?? this.email,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        middle_name: middle_name ?? this.middle_name,
        code: code ?? this.code,
        status: status ?? this.status,
        personalCheck: personalCheck ?? this.personalCheck,
        numberPhone: numberPhone ?? this.numberPhone,
        urlAvatar: urlAvatar ?? this.urlAvatar,
        lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      );

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'email': email,
        'name': name,
        'surname': surname,
        'middle_name': middle_name,
        'code': code,
        'status': status,
        'personalCheck': personalCheck,
        'numberPhone': numberPhone,
        'urlAvatar': urlAvatar,
        'lastMessageTime': lastMessageTime,
      };

  static User fromJson(Map<String, dynamic> json) =>
     User(
      idUser: json['idUser'],
      email: json['email'],
      name: json['name'],
      surname: json['surname'],
      middle_name: json['middle_name'],
      code: json['code'],
      status: json['status'],
      personalCheck: json['personalCheck'],
      numberPhone: json['numberPhone'],
      urlAvatar: json['urlAvatar'],
      lastMessageTime: json['lastMessageTime'],
     );
}
