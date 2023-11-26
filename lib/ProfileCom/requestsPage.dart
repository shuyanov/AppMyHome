import 'package:flutter/material.dart';
import 'package:my_home/Model/User.dart';

import '../Styles/Colors.dart';
import 'Api/api.dart';
import 'data/profileData.dart';
import 'detalPage.dart';

class RequestsPage extends StatefulWidget {
  final User user;
  const RequestsPage({required this.user});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  @override
  Widget build(BuildContext context) {
    bool isIndex = true;
    Future data() async {
      GetRequest();
      var list = getResApi;
      for (int i = 0; i < list.length; i++) {
        if (list[i].status.contains("закрыто") &&
            list[i].status.contains("в работе") &&
            list[i].status.contains("не завершена")) {
          isIndex = true;
        } else
          isIndex = false;
      }
      print('data() successful');
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            GetRequest();
          });
          data();
          return Future.delayed(Duration(seconds: 3));
        },
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: purpleColor,
              foregroundColor: Colors.white,
              snap: false,
              floating: false,
              pinned: false,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(top: 20),
                  centerTitle: true,
                  title: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 8.0, left: 8, right: 8),
                    child: Text(
                        "${profiles[indexProfile].surname} ${profiles[indexProfile].name}",
                        style: TextStyle(fontSize: 30, color: Colors.white)),
                  )),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Заявки",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            FutureBuilder(
                future: GetRequest(),
                builder: (context, AsyncSnapshot snapshot) {
                  data();
                  if (isData) {
                    Future.delayed(Duration(seconds: 1), () {});
                    if (isIndex) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          if (!getResApi[index].status.contains("закрыто") &&
                              !getResApi[index].status.contains("в работе")) {
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
                                              id: getResApi[index].id,
                                              data: getResApi[index].data,
                                              type: getResApi[index].type,
                                              message: getResApi[index].message,
                                              address: getResApi[index].address,
                                              phone: getResApi[index].phone,
                                              userId: getResApi[index].userId,
                                              status:
                                                  getResApi[index].status)));
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          getResApi[index].type,
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
                        }, childCount: getResApi.length),
                      );
                    } else {
                      return SliverFillRemaining(
                          child: Center(
                              child: Text(
                        "Заявок нет\nЗайдите позже",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      )));
                    }
                  }
                  return SliverFillRemaining(
                    child: Center(
                        child: CircularProgressIndicator(
                      color: purpleColor,
                    )),
                  );
                })
          ],
        ),
      ),
    );
  }
}
