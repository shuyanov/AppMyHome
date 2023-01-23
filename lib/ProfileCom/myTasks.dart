import 'package:command_flutter/ProfileCom/requestsPage.dart';
import 'package:flutter/material.dart';

import 'data/profileData.dart';
import 'detalPage.dart';

class myTasks extends StatelessWidget {
  const myTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 50,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "В процессе",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ))),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: profiles[0].tasks.length,
                    itemBuilder: (context, index) {
                      if (profiles[idPerson].tasks[index].isCompleted && !profiles[idPerson].tasks[index].isDone) {
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
                                          date:
                                              profiles[idPerson].tasks[index].date,
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
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        );
                      } else {
                        return SizedBox();
                      }
                    }),
              ),
            ),
          ],
        ),
      
    );
  }
}
