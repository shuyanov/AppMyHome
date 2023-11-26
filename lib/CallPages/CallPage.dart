import 'package:flutter/material.dart';
import 'package:my_home/CallPages/api/firebase.dart';
import 'CallInformation.dart';
import 'Model/Model.dart';
import 'Search/SearchPage.dart';
import '../Styles/Colors.dart';
import 'sendtoEmail.dart';

class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  @override
  void initState() {
    super.initState();
    // baseCall.addCalls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        backgroundColor: purpleColor,
        title: Text("Вызов ремонтных служб"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (builder) => SearchCallPage()));
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: StreamBuilder<List<CallModel>>(
          stream: baseCall.readCalls(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                    child: CircularProgressIndicator(
                  color: purpleColor,
                ));
              default:
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return buildText(
                      'Что-то пошло не так, попробуйте позже зайти');
                } else if (snapshot.hasData) {
                  final users = snapshot.data!;

                  if (users.isEmpty) {
                    return buildText('Произошла ошибка');
                  }
                  return ScrollConfiguration(
                      behavior: ScrollBehavior(),
                      child: GlowingOverscrollIndicator(
                        axisDirection: AxisDirection.down,
                        color: purpleColor,
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          children: users.map(buildCall).toList(),
                        ),
                      ));
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    color: purpleColor,
                  ));
                }
              //   (
              //   child: ScrollConfiguration(
              //     behavior: ScrollBehavior(),
              //     child: GlowingOverscrollIndicator(
              //       axisDirection: AxisDirection.down,
              //       color: purpleColor,
              //       child: ListView.builder(
              //         itemCount: call.length,
              //         itemBuilder: (context, index) => ListTile(
              //           title: Text(
              //             call[index].name,
              //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              //           ),
              //           subtitle: Column(
              //             crossAxisAlignment: CrossAxisAlignment.end,
              //             children: [
              //               Text(call[index].tel[0]),
              //               Text(call[index].tel[1] == "" ? "" : call[index].tel[1]),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: purpleColor,
        child: Icon(Icons.add_ic_call),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => sendtoEmail()));
        },
      ),
    );
  }

  Widget buildCall(CallModel call) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        title: Text(
          call.name,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: greyText),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CallInformation(
                  city: call.city,
                  name: call.name,
                  description: call.description,
                  street: call.street,
                  tel: call.tel)));
        },
      ),
    );
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      );
}
