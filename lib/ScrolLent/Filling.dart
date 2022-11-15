import 'dart:async';
import 'dart:ui';

import 'package:command_flutter/Model/NewsModels.dart';
import 'package:command_flutter/ScrolLent/SurveyPage.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

import '../Data/NewsData.dart';

List<String> listNameVote = [];

class Filing extends StatefulWidget {
  const Filing({Key? key}) : super(key: key);

  @override
  State<Filing> createState() => _FilingState();
}

class _FilingState extends State<Filing> {
  String hint1 = 'Text';
  String hint = 'Title';
  String hn = 'SurvName';
  String ro = 'responopt';
  String img = 'image';
  late String userToDO;
  List<NewsModels> news = [];
  TextEditingController ControlNews = TextEditingController();
  TextEditingController ControlText = TextEditingController();
  TextEditingController ControlCount = TextEditingController();
  TextEditingController ControlnameVote = TextEditingController();
  TextEditingController ControlHeadName = TextEditingController();
  TextEditingController ControlImage = TextEditingController();

  //@override
  /*void _ls() async {
    final conn = await MySQLConnection.createConnection(
      host: "185.231.155.185",
      port: 3306,
      userName: "user",
      password: "password",
      databaseName: "data", // optional
    );
    await conn.connect();
    print("Connected");

    var result = await conn.execute("SELECT * FROM `News`");
    for (final row in result.rows) {
      print(row.colAt(1));
      news.addAll([
        NewsModels(
            HeadName: row.colAt(1).toString(),
            Text: row.colAt(2).toString(),
            image: "",
            isImage: true)
      ]);
    }
  }*/

  /*void setState(callback) async {
    super.setState(() async {
      final conn = await MySQLConnection.createConnection(
        host: "185.231.155.185",
        port: 3306,
        userName: "user",
        password: "password",
        databaseName: "data", // optional
      );
      await conn.connect();
      print("Connected");

      var result = await conn.execute("SELECT * FROM `News`");
      for (final row in result.rows) {
        print(row.colAt(1));
        news.addAll([
          NewsModels(
              HeadName: row.colAt(1).toString(),
              Text: row.colAt(2).toString(),
              image: "",
              isImage: true)
        ]);
      }
    });
}*/

  /*@override
  void setState(_ls()) {
    // TODO: implement setState
    super.setState(_ls);
  }*/
  /*void initState() {
    _ls();
    Timer(Duration(microseconds:5000), ()=> {super.initState()});
    print('hi');
   // print(news);
  }*/
  getValue() async {
      final conn = await MySQLConnection.createConnection(
        host: "185.231.155.185",
        port: 3306,
        userName: "user",
        password: "password",
        databaseName: "data", // optional
      );
      await conn.connect();
      print("Connected");

      var result = await conn.execute("SELECT * FROM `News`");
      for (final row in result.rows) {
        print(row.colAt(1));
        news.addAll([
          NewsModels(
              HeadName: row.colAt(1).toString(),
              Text: row.colAt(2).toString(),
              image: row.colAt(3).toString(),
              isImage: true)
        ]);
      }

      return news;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new FutureBuilder (
      future: getValue(),
      builder: (BuildContext context, AsyncSnapshot newsmodels) {
        return Scaffold(
          backgroundColor: Color.fromARGB(250, 219, 219, 219),
          body: ListView.builder(
            itemCount: news.length,
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
                      news[index].HeadName,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  if (news[index].isImage == true)
                    Container(
                      height: size.height * 0.33,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4)),
                        child: Image.network(news[index].image,
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
                                    value: loadingProgress.expectedTotalBytes != null
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
          floatingActionButton: FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 124, 97, 242),
              child: Icon(Icons.add_circle),
              onPressed: () {
                int count = 0;
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: EdgeInsets.only(bottom: 225, top: 215),
                      margin: EdgeInsets.only(top: 20),
                      child: AlertDialog(
                        contentPadding: EdgeInsets.only(top: 10.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32.0))),
                        title: Text("Добавление"),
                        content: Column(
                          children: [
                            TextButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                            height: 30,
                                            padding: EdgeInsets.only(
                                                bottom: 225, top: 180),
                                            child: AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(32.0))),
                                                title: Text('Добавить новость'),
                                                content: Column(
                                                  children: [
                                                    TextField(
                                                      decoration: InputDecoration(
                                                        hintText: hint,
                                                      ),
                                                      controller: ControlNews,
                                                    ),
                                                    TextField(
                                                      decoration: InputDecoration(
                                                        hintText: hint1,
                                                      ),
                                                      controller: ControlText,
                                                    ),
                                                    TextField(
                                                      decoration: InputDecoration(
                                                        hintText: img,
                                                      ),
                                                      controller: ControlImage,
                                                    )
                                                  ],
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Color.fromARGB(255, 124, 97, 242),
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
                                                    padding:
                                                    EdgeInsets.only(right: 10),
                                                  ),
                                                  ElevatedButton(
                                                      style:
                                                      ElevatedButton.styleFrom(
                                                        backgroundColor: Color.fromARGB(255, 124, 97, 242),
                                                        elevation: 3,
                                                        shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                20.0)),
                                                        minimumSize: Size(100, 50),
                                                      ),
                                                      onPressed: () async {
                                                        setState(() {
                                                          news.add(NewsModels(
                                                              HeadName:
                                                              ControlNews.text,
                                                              Text:
                                                              ControlText.text,
                                                              isImage: true,
                                                              image:
                                                              'https://reemont.ru/wp-content/uploads/2021/06/1620674026_15-p-panelnii-dom-foto-17.jpg'));
                                                        });

                                                        final conn = await MySQLConnection.createConnection(
                                                          host: "185.231.155.185",
                                                          port: 3306,
                                                          userName: "user",
                                                          password: "password",
                                                          databaseName: "data", // optional
                                                        );
                                                        await conn.connect();
                                                        print("Conected ${ControlText.text}");

                                                        var res = await conn.execute(
                                                          "INSERT INTO News (title_news, osn_news, image) VALUES (:title_news, :osn_news, :image)",
                                                          {
                                                            "title_news": ControlNews.text,
                                                            "osn_news": ControlText.text,
                                                            "image": ControlImage.text,
                                                          },
                                                        );

                                                        ControlNews.clear();
                                                        ControlText.clear();
                                                        ControlImage.clear();

                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Text('Добавить')),
                                                  Padding(padding: EdgeInsets.only(left: 10),),
                                                ]));
                                      });
                                },
                                child: const Text("Добавить новость")),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      padding: EdgeInsets.only(bottom: 225, top: 90),
                                      margin: EdgeInsets.only(top: 40),
                                      child: AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(32.0))),
                                        title: Text("Добавить опрос"),
                                        content: Column(children: [
                                          Text(
                                            "Qustions",
                                            style:
                                            TextStyle(color: Colors.black),
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
                                                backgroundColor: Color.fromARGB(255, 124, 97, 242),
                                                elevation: 3,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(20.0)),
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
                                              child: Text("Добавить ответ...")),
                                        ]),
                                        actions: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color.fromARGB(255, 124, 97, 242),
                                              elevation: 3,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(20.0)),
                                              minimumSize: Size(100, 50),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Назад"),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: 30, top: 30),
                                          ),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color.fromARGB(255, 124, 97, 242),
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
                                                    HeadName: ControlHeadName.text,
                                                    Text: ControlnameVote.text,
                                                    image: "",
                                                    isImage: false,
                                                    isSurvey: true,
                                                    nameVote: listNameVote,
                                                  ));
                                                });

                                                final conn = await MySQLConnection.createConnection(
                                                  host: "185.231.155.185",
                                                  port: 3306,
                                                  userName: "user",
                                                  password: "password",
                                                  databaseName: "data", // optional
                                                );
                                                await conn.connect();
                                                print("Conected");

                                                var res = await conn.execute(
                                                  "INSERT INTO News (name_vote, surv_name) VALUES (:name_vote, :surv_name)",
                                                  {
                                                    "name_vote": ControlHeadName.text,
                                                    "surv_name": ControlnameVote.text,
                                                  },
                                                );

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
                                  backgroundColor: Color.fromARGB(255, 124, 97, 242),
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0)),
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
              }),
        );
      },
    );
  }
}

class addNews extends StatelessWidget {
  const addNews({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(children: [
              Text(news[index].HeadName),
              Image.network(news[index].image)
            ]),
          );
        });
  }
}