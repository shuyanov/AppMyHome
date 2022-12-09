import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsModels {
  String HeadName;
  String image;
  String Text;
  bool isImage;
  List<String>? nameVote;
  bool? isSurvey;

  NewsModels({
    required this.HeadName,
    required this.Text,
    required this.image,
    required this.isImage,
    this.nameVote,
    this.isSurvey,
});
}