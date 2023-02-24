import 'package:flutter/material.dart';

import '../Styles/Colors.dart';
import 'Api/api.dart';
import 'detalPage.dart';

class myTasks extends StatefulWidget {
  const myTasks({super.key});

  @override
  State<myTasks> createState() => _myTasksState();
}

class _myTasksState extends State<myTasks> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "В процессе",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ))),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    GetRequestInWork();
                  });
                  Future.delayed(Duration(seconds: 5));
                },
                child: SizedBox(
                  height: size.height * 0.9001,
                  child: FutureBuilder(
                      future: GetRequestInWork(),
                      builder: (context, snapshot) {
                        if (isDataInWork) {
                          Future.delayed(Duration(seconds: 1), () {});
                            return ListView.builder(
                              // physics: BouncingScrollPhysics(),
                              itemCount: getResInWork.length,
                              itemBuilder: (context, index) {
                                if (getResInWork[index].count.toString() ==
                                    "null") {
                                  return Card(
                                    elevation: 10,
                                    child: InkWell(
                                      customBorder: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(3)),
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) {
                                            return detalPage(
                                                id: getResInWork[index].id,
                                                data: getResInWork[index].data,
                                                type: getResInWork[index].type,
                                                message:
                                                    getResInWork[index].message,
                                                address:
                                                    getResInWork[index].address,
                                                phone: getResInWork[index].phone,
                                                userId:
                                                    getResInWork[index].userId,
                                                status:
                                                    getResInWork[index].status);
                                          },
                                        ));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Text(
                                                getResInWork[index]
                                                    .type
                                                    .toString(),
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
                              },
                            );
                        }
                        return Center(
                            child: CircularProgressIndicator(
                          color: purpleColor,
                        ));
                      }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
