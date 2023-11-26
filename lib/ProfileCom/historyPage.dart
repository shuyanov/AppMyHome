import 'package:flutter/material.dart';

import '../Styles/Colors.dart';
import 'Api/api.dart';
import 'components/lineCharts.dart';
import 'data/month.dart';
import 'detalPage.dart';

class historyPage extends StatefulWidget {
  const historyPage({super.key});

  @override
  State<historyPage> createState() => _historyPageState();
}

class _historyPageState extends State<historyPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          GetRequestHistory();
        });
        return Future.delayed(Duration(seconds: 5));
      },
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SizedBox(
          height: size.height * 0.9001,
          child: Padding(
            padding: EdgeInsets.only(top: 10.0, left: 10, right: 10),
            child: Column(
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
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                      Flexible(
                        child: FutureBuilder(
                          future: GetRequestHistory(),
                          builder: (context, snapshot) {
                            if (isDataHis) {
                              print("count: ${getResHis.length}");
                              Future.delayed(Duration(seconds: 1), () {});
                              return ListView.builder(
                                  shrinkWrap: false,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: getResHis.length,
                                  itemBuilder: (context, index) {
                                    if (getResHis[index].count.toString() ==
                                        "null") {
                                      print(
                                          "fff ${getResHis[index].count.toString()}");
                                      return Card(
                                        elevation: 10,
                                        child: InkWell(
                                          customBorder: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        detalPage(
                                                            id: getResHis[index]
                                                                .id,
                                                            data: getResHis[index]
                                                                .data,
                                                            type: getResHis[
                                                                    index]
                                                                .type,
                                                            message: getResHis[
                                                                    index]
                                                                .message,
                                                            address: getResHis[
                                                                    index]
                                                                .address,
                                                            phone: getResHis[
                                                                    index]
                                                                .phone,
                                                            userId:
                                                                getResHis[index]
                                                                    .userId,
                                                            status:
                                                                getResHis[index]
                                                                    .status)));
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Text(
                                                    // "",
                                                    getResHis[index]
                                                        .type
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 30),
                                                  ),
                                                  Text(
                                                    "Нажмите чтобы узнать подробнее...",
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color: Colors.grey),
                                                  )
                                                ]),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return SizedBox();
                                    }
                                  });
                            }
                            return Center(
                                child: CircularProgressIndicator(
                              color: purpleColor,
                            ));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
  return count;
}

int countTasksDone() {
  int count = 0;
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
      style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
      underline: SizedBox(),
      alignment: Alignment.centerRight,
      value: category,
      elevation: 16,
      onChanged: (String? value) {
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
