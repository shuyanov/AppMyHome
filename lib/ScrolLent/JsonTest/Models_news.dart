// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

NewsData NewsDataFromJson(String str) => NewsData.fromJson(json.decode(str));

String welcomeToJson(NewsData data) => json.encode(data.toJson());

class NewsData {
  NewsData({
    //required this.count,
    required this.data,
  });

  //int count;
  List<NewsForUser> data;

  factory NewsData.fromJson(Map<String, dynamic> json) => NewsData(
    //count: json["count"],
    data: List<NewsForUser>.from(json["data"].map((x) => NewsForUser.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    //"count": count,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class NewsForUser {
  NewsForUser({
    required this.id,
    required this.uk,
    required this.code,
    required this.title,
    required this.text,
    required this.image,
  });

  String id;
  String uk;
  String code;
  String title;
  String text;
  String image;

  factory NewsForUser.fromJson(Map<String, dynamic> json) => NewsForUser(
    id: json["id"],
    uk: json["UK"],
    code: json["code"],
    title: json["title"],
    text: json["text"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "UK": uk,
    "code": code,
    "title": title,
    "text": text,
    "image": image,
  };
}
