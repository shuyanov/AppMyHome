import 'dart:async';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_home/Styles/Colors.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Data/NewsData.dart';
import '../Model/NewsModels.dart';
import 'JsonTest/Models_news.dart';
import 'SurveyPage.dart';

List<String> listNameVote = [];

class Filing extends StatefulWidget {
  const Filing({Key? key}) : super(key: key);

  @override
  State<Filing> createState() => _FilingState();
}

class _FilingState extends State<Filing> {
  int last = 5;
  final controller = ScrollController();

  List<NewsForUser> NewsForUsers = [];

  String hint1 = 'Text';
  String hint = 'Title';
  String hn = 'SurvName';
  String ro = 'responopt';
  String img = 'image';
  String status = 'admin';

  late String userToDO;

  // List<NewsModels> newsT = [];
  TextEditingController ControlNews = TextEditingController();
  TextEditingController ControlText = TextEditingController();
  TextEditingController ControlCount = TextEditingController();
  TextEditingController ControlnameVote = TextEditingController();
  TextEditingController ControlHeadName = TextEditingController();
  TextEditingController ControlImage = TextEditingController();

  @override
  void initState() {
    super.initState();
    // fetch();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        // fetch();
      }
      ;
    });
  }

  // Future AddUser() async{
  //   var apiUrl = "http://185.231.155.185/api/login.php";
  //   http.Response reponse = await http.post(Uri.parse(apiUrl),body: {
  //     'login' : "fufaika201@yandex.ru",
  //     'pass' : encoding("5"),
  //       /*'uk' : email,
  //       'personalCheck' : personalCheck,*/
  //   });
  //   var data = jsonDecode(reponse.body);
  //   print("data from api = ${data}");
  // }

  // Future<bool> fetch() async{
  //   final url = Uri.parse("http://185.231.155.185/test_api/getNews.php?all=false&UK=%D0%A8%D0%B5%D1%80%D0%B5%D0%BC%D0%B5%D1%82%D1%8C%D0%B5%D0%B2%D1%81%D0%BA%D0%B0%D1%8F%20%D0%BC%D0%B8%D0%BB%D1%8F&code=9914&first=0&last=$last");
  //   final respone = await http.get(url);
  //   print('respone.statusCode == ${respone.statusCode}');
  //   if (respone.statusCode == 200) {
  //         //Map<String, dynamic> newItem = jsonDecode(respone.body);
  //         // final newItem = json.decode(respone.body);
  //         // first++;
  //         final result = NewsDataFromJson(respone.body);
  //         print('newItem = ${respone.body}');
  //         NewsForUsers = result.data;
  //         setState(() {
  //           last++;
  //         });
  //         return true;
  //         // setState(() {
  //         //   items.addAll(newItem.map<String,dynamic>((items) {
  //         //     final dynamic number = item['id'];
  //         //     return 'Item : ${number}';
  //         //   }).toList());
  //         // });
  //     }
  //   else{
  //         return false;
  //   }
  // }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (status == 'admin') {
      return Center(
        child: Scaffold(
          backgroundColor: Color.fromARGB(250, 219, 219, 219),
          body: ListView.builder(
            controller: controller,
            itemBuilder: (context, index) {
              return ClipRRect(
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        // news[index].HeadName,
                        news[index].headName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        //news[index].Text,
                        news[index].text,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    if (news[index].isImage)
                      Container(
                        // height: size.width,
                        child: ClipRRect(
                          // borderRadius: BorderRadius.only(
                          //     bottomLeft: Radius.circular(4),
                          //     bottomRight: Radius.circular(4)
                          // ),
                          child: Image.network(
                              //news[index].image,
                              news[index].image,
                              fit: BoxFit.cover,
                              // height: size.width,
                              errorBuilder: (context, url, error) => Center(
                                      child: new Text(
                                    "Картинка недоступна.\n Возможно нет интернета или картинка не действительна",
                                    textAlign: TextAlign.center,
                                  )),
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                    child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ));
                              }),
                        ),
                      ),
                  ]),
                ),
              );
            },
            itemCount: news.length,
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 124, 97, 242),
              child: Icon(
                Icons.add_circle,
                color: Colors.white,
              ),
              onPressed: () {
                if (status == "admin") {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Expanded(
                        child: AlertDialog(
                          contentPadding: EdgeInsets.only(top: 10.0),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0))),
                          title: Text("Добавление"),
                          content: Column(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Expanded(
                                              child: AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  32.0))),
                                                  title:
                                                      Text('Добавить новость'),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        TextField(
                                                          decoration:
                                                              InputDecoration(
                                                            hintText: hint,
                                                          ),
                                                          controller:
                                                              ControlNews,
                                                        ),
                                                        TextField(
                                                          decoration:
                                                              InputDecoration(
                                                            hintText: hint1,
                                                          ),
                                                          controller:
                                                              ControlText,
                                                        ),
                                                        TextField(
                                                          decoration:
                                                              InputDecoration(
                                                            hintText: img,
                                                          ),
                                                          controller:
                                                              ControlImage,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  actions: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        purpleColor,
                                                    foregroundColor:
                                                        Colors.white,
                                                    elevation: 3,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0)),
                                                    minimumSize: Size(100, 50),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    "Назад",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                ),
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                              124, 97, 242),
                                                      elevation: 3,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0)),
                                                      minimumSize:
                                                          Size(100, 50),
                                                    ),
                                                    onPressed: () async {
                                                      setState(() {
                                                        news.add(NewsModels(
                                                            headName:
                                                                ControlNews
                                                                    .text,
                                                            text: ControlText
                                                                .text,
                                                            isImage: true,
                                                            image:
                                                                'https://reemont.ru/wp-content/uploads/2021/06/1620674026_15-p-panelnii-dom-foto-17.jpg'));
                                                      });

                                                      // final conn = await MySQLConnection.createConnection(
                                                      //   host: "185.231.155.185",
                                                      //   port: 3306,
                                                      //   userName: "user",
                                                      //   password: "password",
                                                      //   databaseName: "data", // optional
                                                      // );
                                                      // await conn.connect();
                                                      // print("Conected ${ControlText.text}");

                                                      // var res = await conn.execute(
                                                      //   "INSERT INTO News (title_news, osn_news, image) VALUES (:title_news, :osn_news, :image)",
                                                      //   {
                                                      //     "title_news": ControlNews.text,
                                                      //     "osn_news": ControlText.text,
                                                      //     "image": ControlImage.text,
                                                      //   },
                                                      // );

                                                      ControlNews.clear();
                                                      ControlText.clear();
                                                      ControlImage.clear();

                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('Добавить')),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                ),
                                              ]));
                                        });
                                  },
                                  child: const Text("Добавить новость")),
                              TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Expanded(
                                        child: AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(32.0))),
                                          title: Text("Добавить опрос"),
                                          content: Column(children: [
                                            Text(
                                              "Qustions",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            TextField(
                                              decoration: InputDecoration(
                                                hintText: hn,
                                              ),
                                              controller: ControlHeadName,
                                            ),
                                            Text("Response options",
                                                style: TextStyle(
                                                    color: Colors.black)),
                                            TextField(
                                              decoration: InputDecoration(
                                                hintText: ro,
                                              ),
                                              controller: ControlnameVote,
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 124, 97, 242),
                                                  elevation: 3,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  minimumSize: Size(100, 50),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    listNameVote.clear();
                                                  });
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SurveyPage()));
                                                },
                                                child:
                                                    Text("Добавить ответ...")),
                                          ]),
                                          actions: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color.fromARGB(
                                                    255, 124, 97, 242),
                                                elevation: 3,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0)),
                                                minimumSize: Size(100, 50),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Назад"),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: 30, top: 30),
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 124, 97, 242),
                                                  elevation: 3,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  minimumSize: Size(100, 50),
                                                ),
                                                onPressed: () async {
                                                  setState(() {
                                                    news.add(NewsModels(
                                                      headName:
                                                          ControlHeadName.text,
                                                      text:
                                                          ControlnameVote.text,
                                                      image: "",
                                                      isImage: false,
                                                      isSurvey: true,
                                                      nameVote: listNameVote,
                                                    ));
                                                  });

                                                  // final conn = await MySQLConnection.createConnection(
                                                  //   host: "185.231.155.185",
                                                  //   port: 3306,
                                                  //   userName: "user",
                                                  //   password: "password",
                                                  //   databaseName: "data", // optional
                                                  // );
                                                  // await conn.connect();
                                                  // print("Conected");

                                                  // var res = await conn.execute(
                                                  //   "INSERT INTO News (name_vote, surv_name) VALUES (:name_vote, :surv_name)",
                                                  //   {
                                                  //     "name_vote": ControlHeadName.text,
                                                  //     "surv_name": ControlnameVote.text,
                                                  //   },
                                                  // );

                                                  ControlHeadName.clear();
                                                  ControlnameVote.clear();

                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Добавить опрос')),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: const Text("Добавить опрос"),
                              ),
                              Padding(padding: EdgeInsets.only(top: 30)),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 124, 97, 242),
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    minimumSize: Size(100, 50),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Назад"))
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
        ),
      );
    } else {
      return Center(
        child: Scaffold(
          backgroundColor: Color.fromARGB(250, 219, 219, 219),
          body: ListView.builder(
            itemCount: NewsForUsers.length,
            itemBuilder: (context, int index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(children: [
                  if (news[index].isSurvey == true)
                    Container(
                        margin: EdgeInsets.only(left: 2),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Голосование",
                              style: TextStyle(fontSize: 14),
                            ))),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      //news[index].HeadName,
                      NewsForUsers[index].title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      //news[index].Text,
                      NewsForUsers[index].text,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  if (news[index].isImage == true)
                    Container(
                      height: size.height * 0.33,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4)),
                        child: Image.network(NewsForUsers[index].image,
                            fit: BoxFit.cover,
                            height: size.height * 0.33,
                            errorBuilder: (context, url, error) => Center(
                                    child: new Text(
                                  "Картинка недоступна.\n Возможно нет интернета или картинка не действительна",
                                  textAlign: TextAlign.center,
                                )),
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                  child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ));
                            }),
                      ),
                    ),
                  if (news[index].isSurvey == true)
                    Container(
                      height: 200,
                      child: ListView.builder(
                          itemCount: news[index].nameVote?.length,
                          itemBuilder: (context, i) {
                            return SizedBox(
                              width: size.width,
                              child: ElevatedButton(
                                child: Text(news[index].nameVote![i]),
                                onPressed: () {},
                              ),
                            );
                          }),
                    ),
                ]),
              );
            },
          ),
        ),
      );
    }
  }
}
