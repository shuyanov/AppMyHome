import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Styles/Colors.dart';
import 'Api/api.dart';

bool isClicked = false;
bool isDone = false;

class detalPage extends StatefulWidget {
  const detalPage(
      {required this.id,
      required this.data,
      required this.type,
      required this.message,
      required this.address,
      required this.phone,
      required this.userId,
      required this.status,
      super.key});
  final id;
  final data;
  final type;
  final message;
  final address;
  final phone;
  final userId;
  final status;

  @override
  State<detalPage> createState() => _detalPageState();
}

class _detalPageState extends State<detalPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dateFormat = new DateFormat("dd.MM.yyyy");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: purpleColor,
          title: Text("Описание"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                          height: 100,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                widget.type,
                                style: TextStyle(fontSize: 35),
                              ))),
                      Text(widget.message, style: TextStyle(fontSize: 25)),
                      SizedBox(
                        height: 50,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Table(
                          columnWidths: {
                            0: FixedColumnWidth(80),
                            1: FlexColumnWidth(1)
                          },
                          children: [
                            TableRow(children: [
                              Text("Дата: ", style: TextStyle(fontSize: 15)),
                              Text(
                                // dateFormat.format(widget.data),
                                widget.data,
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.right,
                              ),
                            ]),
                            TableRow(children: [
                              Text("Телефон: ", style: TextStyle(fontSize: 15)),
                              Text(
                                widget.phone,
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.right,
                              ),
                            ]),
                            TableRow(children: [
                              Text("Адрес: ", style: TextStyle(fontSize: 15)),
                              Text(
                                widget.address,
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.right,
                              ),
                            ]),
                            TableRow(children: [
                              Text("Статус: ", style: TextStyle(fontSize: 15)),
                              Text(
                                widget.status,
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.right,
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (!widget.status.contains("в работе") &&
                  !widget.status.contains("закрыто"))
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text(
                    "Принять в работу",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: purpleColor),
                ),
              if (widget.status.contains("в работе") &&
                  !widget.status.contains("закрыто"))
                SizedBox(
                  height: 40,
                  child: Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text("Подтверждение"),
                                  content: Text("Вы выполнили задание?"),
                                  actions: [
                                    TextButton(
                                        child: Text('Нет'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        }),
                                    TextButton(
                                        child: Text('Да'),
                                        onPressed: () async {
                                          CloseRequest(widget.id);
                                          GetRequestInWork();
                                          Future.delayed(Duration(seconds: 5));
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                        }),
                                  ],
                                ));
                      },
                      child: Text(
                        "Выполнено",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                    ),
                  ),
                ),
              if (widget.status.contains("закрыто"))
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 3, color: Colors.red),
                    color: Colors.red.withOpacity(0.5),
                  ),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Закрыто",
                        style: TextStyle(fontSize: 20, color: Colors.red[800]),
                      )),
                )
            ],
          ),
        ),
      ),
    );
  }
}
