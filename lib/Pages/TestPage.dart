import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Второе окно')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              SizedBox(width: 12,),
              Expanded(
                  child:Container(
                    // child: ElevatedButton(
                    //
                    //     child: Text("1", style: TextStyle(fontSize: 22),),
                    //     onPressed:(){}
                    // ),
                    child: ButtonTheme(
                        buttonColor: Colors.green,// Белый цвет кнопок
                        minWidth: 40,// Минимальная ширина
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      child: Text("sd"),
                        ),
                    )
              ),
              // Expanded(
              //     child:ElevatedButton(
              //         child: Text("2", style: TextStyle(fontSize: 22)),
              //         onPressed:(){}
              //     ) ),
              // Expanded(
              //     child:ElevatedButton(
              //         child: Text("3", style: TextStyle(fontSize: 22)),
              //         onPressed:(){}
              //     ) ),
            ],
          ),
        ),
      ),
    );
  }
}