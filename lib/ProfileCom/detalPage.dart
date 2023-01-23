import 'package:command_flutter/Styles/Colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

bool isClicked = false;
bool isDone = false;

class detalPage extends StatefulWidget {
  const detalPage(
      {required this.nameTask,
      required this.description,
      required this.date,
      required this.period,
      required this.isCompleted,
      required this.isDone,
      super.key});
  final nameTask;
  final description;
  final date;
  final period;
  final isCompleted;
  final isDone;

  @override
  State<detalPage> createState() => _detalPageState();
}

class _detalPageState extends State<detalPage> {
  @override
  void initState() {
    super.initState();
    isClicked = widget.isCompleted;
    isDone = widget.isDone;
  }

  /*
      nameTask,
      description,
      date,
      period,
      isCompleted
  */
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
                                widget.nameTask,
                                style: TextStyle(fontSize: 35),
                              ))),
                      Text(widget.description, style: TextStyle(fontSize: 25)),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Table(
                          columnWidths: {
                            0: FixedColumnWidth(80),
                            1: FixedColumnWidth(80)
                          },
                          children: [
                            TableRow(children: [
                              Text("Дата: ", style: TextStyle(fontSize: 15)),
                              Text(
                                dateFormat.format(widget.date),
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.right,
                              ),
                            ]),
                            TableRow(children: [
                              Text("Срок до: ", style: TextStyle(fontSize: 15)),
                              Text(
                                dateFormat.format(widget.period),
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.right,
                              ),
                            ])
                          ],
                        ),
                      ),
                      // Text(dateFormat.format(widget.date), style: TextStyle(fontSize: 15)),
                      // Text(dateFormat.format(widget.period), style: TextStyle(fontSize: 15)),
                    ],
                  ),
                ),
              ),
              if (!isClicked && !isDone)
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (!isClicked)
                        isClicked = true;
                      else
                        isClicked = false;
                    });
                  },
                  child: Text(
                    isClicked != true ? "Принять" : "Отменить",
                    style: TextStyle(
                        color: isClicked != true ? Colors.white : purpleColor),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isClicked != true ? purpleColor : Colors.white),
                ),
              if (isClicked && !isDone)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (isClicked)
                              isClicked = false;
                            else
                              isClicked = true;
                          });
                        },
                        child: Text(
                          "Отменить",
                          style: TextStyle(color: purpleColor),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    // S(),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (isDone)
                              isDone = false;
                            else
                              isDone = true;
                          });
                        },
                        child: Text(
                          "Готово",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                      ),
                    ),
                  ],
                ),
              if (isDone)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 3, color: Colors.green),
                    color: Colors.green.withOpacity(0.5),
                  ),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Align(alignment: Alignment.center, child: Text("Готово", style: TextStyle(fontSize: 20))),
                )
            ],
          ),
        ),
      ),
    );
  }
}
