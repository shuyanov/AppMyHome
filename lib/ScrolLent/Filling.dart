import 'package:command_flutter/Model/NewsModels.dart';
import 'package:flutter/material.dart';

import '../Data/NewsData.dart';

class Filing extends StatefulWidget {
  const Filing({Key? key}) : super(key: key);

  @override
  State<Filing> createState() => _FilingState();
}

class _FilingState extends State<Filing> {

  String hint1 = 'Text';
  String hint = 'Title';
  late String userToDO;
  List<NewsModels> news = [];
  TextEditingController ControlNews = TextEditingController();
  TextEditingController ControlText = TextEditingController();
  @override
  void initState() {
    super.initState();

    news.addAll([NewsModels(
        HeadName: 'Отключение газа в Иввановской области',
        Text: 'По информации компании, в связи с выполнением работ по ремонту газораспределительной сети по адресу: проезд Институтский, д. 1, ул. Парижской Коммуны, д. 58-а в г. Иваново будет прекращено газоснабжение жилых домов ',
        image: 'https://reemont.ru/wp-content/uploads/2021/06/1620674026_15-p-panelnii-dom-foto-17.jpg'),
      NewsModels(
          HeadName: 'Три микрорайона в Иванове останутся без горячей воды',
          Text: 'Когда именно и на какой период дома останутся без ГВС, ресурсоснабжающая компания чётко не сообщает, но обещает, что отключение будет непродолжительным.В целом, работы планирую выполнить за 10 часов 20-21 августа. Для минимизации неудобств - в вечернее и ночное время.',
          image: 'https://media.makler.md/production/an/original/000/048/490/000048490366.jpg'),
      NewsModels(
          HeadName: 'Взрыв газа произошел в российском городе',
          Text: 'Взрыв газа произошел в многоквартирном жилом доме в дагестанском Каспийске, три человека получили ожоги. Об этом сообщает местная прокуратура. Инцидент произошел на улице Молодежная, 5. По предварительным данным, взрыв случился в одной из квартир. ',
          image: 'https://na-dache.pro/uploads/posts/2021-11/1636546150_185-na-dache-pro-p-panelnii-dom-foto-208.jpg'),
      NewsModels(
          HeadName: 'В Волгограде расползается крыша многоквартирного дома',
          Text: 'Взрыв газа произошел в многоквартирном жилом доме в дагестанском Каспийске, три человека получили ожоги. Об этом сообщает местная прокуратура. Инцидент произошел на улице Молодежная, 5. По предварительным данным, взрыв случился в одной из квартир.',
          image: 'https://na-dache.pro/uploads/posts/2021-11/1636546150_185-na-dache-pro-p-panelnii-dom-foto-208.jpg'),
      NewsModels(
          HeadName: 'HeadName',
          Text: 'Взрыв газа произошел в многоквартирном жилом доме в дагестанском Каспийске, три человека получили ожоги. Об этом сообщает местная прокуратура. Инцидент произошел на улице Молодежная, 5. По предварительным данным, взрыв случился в одной из квартир.',
          image: 'https://na-dache.pro/uploads/posts/2021-11/1636546150_185-na-dache-pro-p-panelnii-dom-foto-208.jpg'),
    ]);
  }

  @override
  Widget build(BuildContext context) {
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle),
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.only(bottom: 20, top: 20),
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
                  ElevatedButton(onPressed: () {
                    setState(() {
                      news.add(NewsModels(HeadName: ControlNews.text, Text: ControlText.text, image: 'https://reemont.ru/wp-content/uploads/2021/06/1620674026_15-p-panelnii-dom-foto-17.jpg'));
                    });
                    Navigator.of(context).pop();
                  }, child: Text('Добавить'))
                ],
              ),
            );
          });
        },
      ),
    );
  }
}


/*
class Filing extends StatelessWidget {
  const Filing({Key? key}) : super(key: key);

  String _userToDo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: news.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image.network(news[index].image),
              title: Text(news[index].HeadName),
              subtitle: Text(news[index].Text),
            );
          },
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Добавить Новость'),
              content: TextField(
                onChanged: (String value) {
                  setState(() {
                    _userToDo = value;
                  });
                },
              ),
            );
          });
        },
        child: Icon(
          Icons.add_circle,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}

*/
