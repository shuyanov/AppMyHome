/*
import 'package:command_flutter/Model/NewsModels.dart';
import 'package:flutter/material.dart';

class Crreat extends StatefulWidget {
  const Crreat({Key? key}) : super(key: key);

  @override
  State<Crreat> createState() => _CrreatState();
}

class _CrreatState extends State<Crreat> {

  String hint1 = 'Text';
  String hint = 'Title';
  late String userToDO;
  List<NewsModels> news = [];
  TextEditingController ControlNews = TextEditingController();
  TextEditingController ControlText = TextEditingController();

  @override
  void initState() {
    super.initState();
    news.addAll([]);
  }
  Widget _news() {
    return Scaffold(
      backgroundColor: Color.fromARGB( 255, 105, 193, 238),
      body: ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, int index) {
          return ListTile(
            leading: Image.network(news[index].image),
            title: Text(news[index].HeadName),
            subtitle: Text(news[index].Text),
          );
        },
      ),
    );
  }

  Widget _creat() {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle),
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context) {
            return Container(
              child: AlertDialog(
                title: Text('Добавить новость'),
                content: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        showDialog(context: context, builder: (BuildContext) {
                          return Container(
                            child: AlertDialog(
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
                                  )
                                ],
                              ),
                              actions: [
                                Row(
                                  children: [
                                    ElevatedButton(onPressed: () {
                                      setState(() {
                                        news.add(NewsModels(HeadName: ControlNews.text, Text: ControlText.text, image: 'https://reemont.ru/wp-content/uploads/2021/06/1620674026_15-p-panelnii-dom-foto-17.jpg'));
                                      });
                                      Navigator.of(context).pop();
                                    }, child: Text('Добавить')),
                                    ElevatedButton(onPressed: () {
                                      Navigator.of(context).pop();
                                    }, child: Text("Назад"))
                                  ],
                                ),
                                */
/**//*

                              ],
                            ),
                          );
                        });
                      },
                      child: const Text("Добавить новость"),
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(context: context, builder: (BuildContext) {
                          return Container(
                            child: AlertDialog(
                              content: Column(
                                children: [

                                ],
                              ),
                              actions: [

                              ],
                            ),
                          );
                        });
                      },
                      child: const Text("Добавить опрос"),
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _news(),
              _creat()
            ],
          ),
        ),
      ),
    );
  }
}
*/
