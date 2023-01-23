import 'package:command_flutter/ProfileCom/data/profileData.dart';
import 'package:command_flutter/ProfileCom/detalPage.dart';
import 'package:command_flutter/ProfileCom/requestsPage.dart';
import 'package:flutter/material.dart';

import 'components/lineCharts.dart';
import 'data/month.dart';

class historyPage extends StatelessWidget {
  const historyPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 10.0, left: 10, right: 10),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Статистика",
              style: TextStyle(
                fontSize: 35,
              ),
            ),
            LineCharts(),
            SizedBox(height: 150, child: TotalMonth()),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 200,
              child: Column(
                children: [
                  Text(
                    "Выполненные заявки",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: false,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: profiles[0].tasks.length,
                        itemBuilder: (context, index) {
                          if (profiles[idPerson].tasks[index].isDone) {
                            return Card(
                              elevation: 10,
                              child: InkWell(
                                customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => detalPage(
                                              nameTask: profiles[idPerson]
                                                  .tasks[index]
                                                  .nameTask,
                                              description: profiles[idPerson]
                                                  .tasks[index]
                                                  .description,
                                              date: profiles[idPerson]
                                                  .tasks[index]
                                                  .date,
                                              period: profiles[idPerson]
                                                  .tasks[index]
                                                  .period,
                                              isCompleted: profiles[idPerson]
                                                  .tasks[index]
                                                  .isCompleted,
                                              isDone: profiles[idPerson]
                                                  .tasks[index]
                                                  .isDone)));
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          profiles[idPerson]
                                              .tasks[index]
                                              .nameTask,
                                          style: TextStyle(fontSize: 30),
                                        ),
                                        Text(
                                          "Нажмите чтобы узнать подробнее...",
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: Colors.grey),
                                        )
                                      ]),
                                ),
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TotalMonth extends StatelessWidget {
  const TotalMonth({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        Align(
            alignment: Alignment.center,
            child: Text(
              "Итого за месяц",
              style: TextStyle(fontSize: 25),
            )),
        Spacer(),
        const _dropButton()
      ]),
      SizedBox(
        height: 10,
      ),
      Table(
        columnWidths: {
          0: FlexColumnWidth(1),
          1: FixedColumnWidth(50),
        },
        children: [
          TableRow(children: [
            SizedBox(
              child: Text("Кол-во заявок принятых в работу:",
                  style: TextStyle(fontSize: 20)),
            ),
            Text(
              countTasksComplete().toString(),
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.right,
            ),
          ]),
          TableRow(children: [
            SizedBox(
              child: Text("Кол-во выполненных заявок:",
                  style: TextStyle(fontSize: 20)),
            ),
            Text(
              countTasksDone().toString(),
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.right,
            ),
          ]),
        ],
      )
    ]);
  }
}

int countTasksComplete() {
  int count = 0;
  for (int i = 0; i < profiles[idPerson].tasks.length; i++) {
    if (profiles[idPerson].tasks[i].isCompleted &&
        !profiles[idPerson].tasks[i].isDone) count += 1;
  }

  return count;
}

int countTasksDone() {
  int count = 0;
  for (int i = 0; i < profiles[idPerson].tasks.length; i++) {
    if (profiles[idPerson].tasks[i].isDone) count += 1;
  }

  return count;
}

String category = month.first;

class _dropButton extends StatefulWidget {
  const _dropButton();

  @override
  State<_dropButton> createState() => _dropButtonState();
}

class _dropButtonState extends State<_dropButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      // disabledHint: const Text(
      //   "Выберите месяц",
      //   style: TextStyle(fontSize: 20),
      // ),
      // hint: const Text(
      //   "Выберите месяц",
      //   style: TextStyle(fontSize: 20),
      // ),
      style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
      //style: TextStyle(fontSize: 20),
      underline: SizedBox(),
      alignment: Alignment.centerRight,
      value: category,
      elevation: 16,
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          category = value!;
        });
      },
      items: month.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(fontSize: 20),
          ),
        );
      }).toList(),
    );
  }
}
