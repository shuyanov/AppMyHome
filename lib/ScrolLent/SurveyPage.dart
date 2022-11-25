import 'package:command_flutter/ScrolLent/Filling.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  TextEditingController ControlnameVote = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 124, 97, 242),
        title: Text("Добавление ответа"),
      ),
      body: 
          Expanded(
            child: ListView.builder(
              itemCount: listNameVote.length,
              itemBuilder: (context, index) {
                return Text(listNameVote[index]);
              },
            ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 124, 97, 242),
          child: Icon(Icons.add), onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Expanded(
                  child: AlertDialog(
                    title: Text("Добавить ответ"),
                    content: TextField(
                  decoration: InputDecoration(
                    hintText: "Добавить ответ...",
                  ),
                  controller: ControlnameVote,
                ),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
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
                          listNameVote.add(ControlnameVote.text.toString());
                          print("Название: ${ControlnameVote.text.toString()}");
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

                        var result = await conn.execute(
                          "INSERT INTO News (surv_name) VALUES (:surv_name)",
                          {
                            "surv_name": ControlnameVote.text,
                          },
                        );

                        ControlnameVote.clear();

                        Navigator.of(context).pop();
                      },
                      child: Text("Добавить"))
                ],
              ));
            });
      }
      
      ),
    );
  }
}
