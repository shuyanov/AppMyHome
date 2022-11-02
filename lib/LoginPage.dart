import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:command_flutter/RegisterPage.dart';
import 'package:command_flutter/main.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mysql_client/mysql_client.dart';

import 'HomePage.dart';

class LoginPage extends StatelessWidget {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool logged = false;
  String email = "";
  String password = "";


  @override
////////////////////
  Widget _logo(){
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/logo1.png'),
              fit: BoxFit.cover
          )
      ),
      padding: EdgeInsets.only(top: 400, bottom: 60),
    );
  }
//////////////////
//////////////////
  Widget _form(){
    return Container(

      child: Column(
        children: [

          Padding(
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: _input(Icon(Icons.email), "+7-912-345-67-89", emailController, false),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 20,),
            child: _input(Icon(Icons.lock), "PASSWORD", passwordController, true),
          ),

          SizedBox(height: 20,),
          Padding(
              child: Container(
                height: 60,
                width: 150,
                child: _logButton(),

              ),
              padding: EdgeInsets.only(left: 20,right: 20,bottom: 10 )
          ),

        ],
      ),
    );
  }
///////////////////
  String encoding(String value){
    var byte = utf8.encode(value);

    var digest = sha256.convert(byte);
    return digest.toString();
  }
///////////////////
  Widget _regButton(){

    return Container(
        margin: EdgeInsets.only(top: 6),
        height: 42,
        width: 110,
        child: ElevatedButton(
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
//////////////////

/////////////////
  Widget _logButton(){
    return Container(

        child:

        ElevatedButton(
          child: Text("LOGIN", style: TextStyle(color: Colors.cyan, fontSize: 26)),
          onPressed: () => funcPress(),
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
/////////

////////
  void funcPress(){

    logged = false;
    print("login button");
    Future<void> _LoginButtonActio() async {
      email = emailController.text;
      password = passwordController.text;
      print("login: login = ${email} password = ${password}");

      emailController.clear();
      passwordController.clear();

      print("Connecting to mysql server...");
// create connection
      final conn = await MySQLConnection.createConnection(
        host: "10.0.2.2",
        port: 3306,
        userName: "root",
        password: "123SQL",
        databaseName: "users", // optional
      );
      await conn.connect();
      print("Connected");

      var result = await conn.execute("SELECT * FROM auth_users"); //слать запрос напрямую в БД, без сохраения всех данных


      for (final row in result.rows) {
        print(row.colAt(1));
        print(row.colAt(2));
        if (row.colAt(1) == email && row.colAt(2) == encoding(password)) {
          print("YES MATCH!!! login");
          logged = true;
//запись в json
          Timer(Duration(seconds: 1), () {
            if(logged) {runApp(MyApp()); PushToJson(email, password, "no", "no", "no", "no"); };
            print("Yeah, this line is printed after 3 seconds");
            return logged ? runApp(MyApp()) : runApp(LoginPage());
          });
//сохранить в буфер
        }
        else {
          print("no match");
        }
      }
// close all connections
      await conn.close();
      print("close");
    }
    _LoginButtonActio();
    print("exit");
  }
//////////////////
  void PushToJson(String login, String password, String surname, String name, String middle_name, String code) async {

    final directory =
    await pathProvider.getApplicationSupportDirectory();
    final fileDirectory = directory.path + '/datas.json';
    final file = File(fileDirectory);
    await file.writeAsString('{\"user\": {\"login\" : \"$login\"\,\"password\" : \"$password\",\"surname\" : \"$surname\",\"name\" : \"$name\",\"middle_name\" : \"$middle_name\",\"code\" : \"$code\"}}');
    final res = await file.readAsString();
    print("created json: $res");

  }
//////////////////
  Widget _input(Icon icon, String hint, TextEditingController controller, bool hidden){
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20),
      child: TextField(
        controller: controller,
        obscureText: hidden,
        style: TextStyle(fontSize: 20, color: Colors.white),
        decoration: InputDecoration(
          hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white30),
          hintText: hint,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 3)
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white54, width: 1)
          ),
          prefixIcon: Padding(padding: EdgeInsets.only(left: 10, right: 10),
            child: IconTheme(
              data: IconThemeData(
                  color: Colors.yellow
              ),
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
/////////////////

/////////////////

  Widget build(BuildContext context) {
    print('LoginPage');
    return MaterialApp( home: Scaffold(
        backgroundColor: Color.fromARGB(200, 105, 193, 238),
        body:
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _logo(),
              _form(),
              _regButton(),
            ],
          ),
        )
    ),
    );
  }
}