import 'package:command_flutter/Model/NewsModels.dart';
import 'package:flutter/material.dart';

import '../Data/NewsData.dart';


class Filing extends StatelessWidget {
  const Filing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.network(news[index].image),
          title: Text(news[index].HeadName),
          subtitle: Text(news[index].Text),
        );
        /*Container(
          constraints: BoxConstraints(maxWidth: 200),

              child: Column(
                children: [
                  Text(news[index].HeadName,),
                  Row(
                    children: [
                      Image.network(news[index].image, width: 100, height: 100,),
                      Flexible(child: Text(news[index].Text,))
                    ],
                  ),
                ],
              ),
            );*/
      },
    );

    /*Row(
      children: [
        Text(newsModels.HeadName),
        Column(
          children: [
              Image.Network(newModels)
          ],
        ),
      ],
    );*/

    /*Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Container(
              color: Colors.black87,
              child: Text('kf', style: TextStyle(fontSize: 40) ),
            )
          ],
        ),
        Column(
          children: [
            Container(
                child: IconButton(
                  icon: const Icon(Icons.arrow_drop_down) ,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute<void>(
                        builder: (BuildContext){
                          return Scaffold(
                            appBar: AppBar(
                              title: const Text('Уведомления'),
                              backgroundColor: Colors.blueAccent,
                            ),
                          );
                        }
                    ));
                  },
                )
            )
          ],
        ),
      ],
    );*/
  }
}

