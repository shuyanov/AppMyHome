import 'package:command_flutter/ProfileCom/data/profileData.dart';
import 'package:command_flutter/ProfileCom/detalPage.dart';
import 'package:flutter/material.dart';
int idPerson = 0;
class requestsPage extends StatelessWidget {
  const requestsPage({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                alignment: Alignment.center,
                height: size.height * 0.2,
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      profiles[idPerson].name,
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(
                      profiles[idPerson].job,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                )),
            Text(
              "Заявки",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: ListView.builder(
                  // physics: const ClampingScrollPhysics(),
                  physics: BouncingScrollPhysics(),
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: profiles[idPerson].tasks.length,
                  itemBuilder: (context, index) => !profiles[idPerson]
                              .tasks[index]
                              .isCompleted
                      ? Card(
                          elevation: 10,
                          child: InkWell(
                            customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3)),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => detalPage(
                                          nameTask:
                                              profiles[idPerson].tasks[index].nameTask,
                                          description: profiles[idPerson]
                                              .tasks[index]
                                              .description,
                                          date: profiles[idPerson].tasks[index].date,
                                          period:
                                              profiles[idPerson].tasks[index].period,
                                          isCompleted: profiles[idPerson]
                                              .tasks[index]
                                              .isCompleted,
                                              isDone: profiles[idPerson]
                                                .tasks[index].isDone)));
                            },
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      profiles[idPerson].tasks[index].nameTask,
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
                        )
                      : SizedBox()),
            ),
          ],
        ),
      ),
    );
  }
}
