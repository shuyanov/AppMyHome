import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:command_flutter/Chats/Data/Admin.dart';
import 'package:command_flutter/Chats/Models/User.dart';
import 'package:command_flutter/Chats/api/firebase.dart';
import 'package:command_flutter/GeneralChats/Models/User.dart';
import 'package:http/http.dart' as http;
import 'package:command_flutter/Registre_and_Login/RecPassword.dart';
import 'package:command_flutter/Registre_and_Login/Password.dart';
import 'package:command_flutter/Utils/UserPerefer.dart';


import 'package:command_flutter/main.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';

import '../Chats/Data/users.dart';
import '../addUser.dart';

class Recpassword extends StatefulWidget {
  const Recpassword({Key? key}) : super(key: key);

  @override
  State<Recpassword> createState() => _RecpasswordState();
}

class _RecpasswordState extends State<Recpassword> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Recpassw(),
    );
  }
}

class Recpassw extends StatelessWidget {
  Recpassw({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController pasCod = TextEditingController();

  Widget _logo() {
    return Padding(
      padding: EdgeInsets.only( bottom: 10),
      child: Container(
        child: Align(
          child: Image.asset('assets/mainLogo.png'),
        ),
      ),
    );
  }

  Widget _input(Icon icon, String hint, TextEditingController controller, bool hidden){
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20),
      child: TextField(
        controller: controller,
        obscureText: hidden,
        style: TextStyle(fontSize: 20, color: Color.fromARGB(200, 120, 95, 221)),
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(200, 227, 228, 251),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0)),
          hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey),
          hintText: hint,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(200, 227, 228, 251), width: 3),
            borderRadius: BorderRadius.circular(30.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(200, 227, 228, 251), width: 1),
            borderRadius: BorderRadius.circular(30.0),
          ),
          prefixIcon: Padding(padding: EdgeInsets.only(left: 10, right: 10),
            child: IconTheme(
              data: IconThemeData(
                  color: Colors.purple
              ),
              child: icon,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _logo(),
            Container(
              height: size.height,
              width: size.height,
              child: Scaffold(
                body: Column(
                  children: [
                    Padding(
                      padding:const EdgeInsets.only(bottom: 150, top: 100,),
                      child: _input(Icon(Icons.password), "Код из SMS", pasCod, false),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20,right: 20,bottom: 10 ),
                      child: Container(
                          height: 60,
                          width: 210,
                          child: ElevatedButton(
                            child: Text("Восстановить", style: TextStyle(color: Colors.white, fontSize: 26)),
                            onPressed: () {
                              return runApp(Password());
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(200, 158, 122, 244),
                              onPrimary: Colors.cyan,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20,right: 20,bottom: 10 ),
                      child: Container(
                          height: 60,
                          width: 150,
                          child: ElevatedButton(
                            child: Text("НАЗАД", style: TextStyle(color: Colors.white, fontSize: 26)),
                            onPressed: () {
                              return runApp(RecPassword());
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(200, 158, 122, 244),
                              onPrimary: Colors.cyan,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*Padding(padding: const EdgeInsets.only(bottom: 15, top: 30,),
              child: Text("ВВведите код из sms"),
            ),*/