import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsModels {
  String headName;
  String image;
  String text;
  bool isImage;
  List<String>? nameVote;
  bool? isSurvey;

  NewsModels({
    required this.headName,
    required this.text,
    required this.image,
    required this.isImage,
    this.nameVote,
    this.isSurvey,
});
}