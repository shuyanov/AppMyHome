import 'package:flutter/material.dart';

import 'Data/dataCall.dart';
import 'Model/Model.dart';
import 'Search/SearchPage.dart';
import '../Styles/Colors.dart';

class CallPage extends StatelessWidget {
  const CallPage({super.key});

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
                    MaterialPageRoute(builder: (builder) => SearchPage()));
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: ListView.builder(
        itemCount: call.length,
        itemBuilder: (context, index) => ListTile(title: Text(call[index].name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(call[index].tel[0]),
            Text(call[index].tel[1] == "" ? "" : call[index].tel[1]),
          ],
        ),),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: purpleColor,
        child: Icon(Icons.add_ic_call),
        onPressed: (){},
      ),
    );
  }
}
