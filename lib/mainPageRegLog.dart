import 'package:command_flutter/RegisterPage.dart';
import 'package:flutter/material.dart';
import 'LoginPageF.dart';

class mainPageRegLog extends StatelessWidget {

////////////////////
  Widget _regButton(){

    return Container(
        margin: EdgeInsets.only(top: 6),
        height: 42,
        width: 150,
        child:  ElevatedButton(
          child: Text("REGISTER", style: TextStyle(color: Colors.cyan, fontSize: 17)),
          onPressed: (){ print('tap-tap'); return runApp(RegisterPage()); },
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.cyan,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        )
    );
  }
  //////////////////////
  Widget _logPageButton(){

    return Container(
        margin: EdgeInsets.only(top: 8, bottom: 8),
        // padding: EdgeInsets.only(top: 8),
        height: 42,
        width: 150,
        child:  ElevatedButton(
          child: Text("LOGIN", style: TextStyle(color: Colors.cyan, fontSize: 18)),
          onPressed: (){ print('tap-tap'); return runApp(LoginPageF()); },
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.cyan,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        )
    );
  }
  //////////////////////
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:

         Scaffold(
            backgroundColor: Colors.cyan,
           body:  Padding(
             padding: EdgeInsets.only(top: 360),
             child: Align(
               alignment: Alignment(0,0),
                child: Column(
                  children: <Widget>[
                    _regButton(),
                    _logPageButton(),
                ],
              ),
            ),
          ),
         )
    );
  }
  }

