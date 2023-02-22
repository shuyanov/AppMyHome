import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:command_flutter/Utils/UserPerefer.dart';

import 'package:command_flutter/Chats/Models/User.dart';
import 'package:command_flutter/Chats/api/firebase.dart';
import 'package:command_flutter/GeneralChats/Models/User.dart';
import 'package:command_flutter/Login/RegisterPage.dart';


import 'package:command_flutter/main.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:mysql_client/mysql_client.dart';
import '../Chats/Data/users.dart';
import '../addUser.dart';

class LoginPageF extends StatelessWidget {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController surNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();

  String name = "";
  String surName = "";
  String middleName = "";


  bool logged = false;
  String email = "";
  String password = "";


  @override

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
//////////////////
  Widget _form(){
    return Container(

      child: Column(
        children: [

          Padding(
            padding: const EdgeInsets.only(bottom: 15, top: 30,),
            child: Center(
              child: Text(style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600,color: Colors.black54), "ДОБРО ПОЖАЛОВАТЬ!"),
            ),
          ),
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

  String encoding(String value){
    var byte = utf8.encode(value);
    var digest = sha256.convert(byte);
    return digest.toString();
  }


  Widget _regButton(){
    return Container(
        margin: EdgeInsets.only(top: 1),
        height: 36,
        width: 150,
        child: ElevatedButton(
          child: Text("регистрация", style: TextStyle(color: Colors.white, fontSize: 19)),
          onPressed: (){
            return runApp(RegisterPage());
          },

          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(200, 158, 122, 244),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        )
    );
  }

  Widget _logButton(){
    return Container(
        child:
        ElevatedButton(
          child: Text("ВОЙТИ", style: TextStyle(color: Colors.white, fontSize: 26)),
          onPressed: () => funcPress(),
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(200, 158, 122, 244),
            onPrimary: Colors.cyan,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        )
    );
  }

  void funcPress(){

    logged = false;
    print("login button");
    Future<void> _LoginButtonActio() async {
      email = emailController.text;
      password = passwordController.text;

      print("login: login = ${email} password = ${password}");
      //
      if(email=="" || password ==""){
        Fluttertoast.showToast(
            msg: "Ошибка! Необходимо заполнить все поля",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb:
            1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return;
      }
      emailController.clear();
      passwordController.clear();

      print("Connecting to mysql server...");
      final conn = await MySQLConnection.createConnection(
        host: "185.231.155.185",
        port: 3306,
        userName: "appUser",
        password: "123879",
        databaseName: "data", // optional
      );
      await conn.connect();
      print("Connected");
      print("d = ${encoding(password)}");

      var res = await conn.execute("select * from final_user where user_email = '$email'and password = '${encoding(password)}';");
      for (final row in res.rows) {
        if(row.colAt(0)!=null){

          var adMail = await conn.execute("select main_mail from code_table where code = '${row.colAt(7)}';"); //fix this
          String adminEmail = "no";
          for(final rows in adMail.rows){
            if(rows.colAt(0)!=""){ //may be null?
              adminEmail = rows.colAt(0).toString();
              print("ad mail = ${rows.colAt(0)}");
            }
          }
          PushToJsonTest("${row.colAt(1)}", "${row.colAt(2)}", "${row.colAt(3)}", "${row.colAt(4)}", "${row.colAt(5)}", "${row.colAt(7)}", "${row.colAt(0)}", "${row.colAt(6)}", "${row.colAt(8)}", "${row.colAt(9)}", "$adminEmail");
          // Для входа в чат
          addUser("${row.colAt(0)}", "${row.colAt(1)}", "${row.colAt(3)}", "${row.colAt(4)}", "${row.colAt(5)}", "${row.colAt(7)}", "${row.colAt(6)}", "${row.colAt(8)}", "${row.colAt(9)}");
          logged = true;
        }
      }
      if(logged) {
        runApp(MyApp());
        await conn.close();
        print("con close");
        //  PushToJsonTest("email", "${encoding(password)}", surname, name, middle_name, code, id, stateAdmin, personalCheck, numberPhone, adminEmail);
        return runApp(MyApp());
      }
      else{
        Fluttertoast.showToast(
            msg: "Ошибка! Неправильный логин или пароль",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb:
            1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        await conn.close();
        print("con close");
        return runApp(LoginPageF());

      }
    }
    _LoginButtonActio();
    print("exit");
  }

  void PushToJson(String login, String password, String surname, String name, String middle_name, String code) async {

    final directory =
    await pathProvider.getApplicationSupportDirectory();
    final fileDirectory = directory.path + '/datas.json';
    final file = File(fileDirectory);
    await file.writeAsString('{\"user\": {\"login\" : \"$login\"\,\"password\" : \"$password\",\"surname\" : \"$surname\",\"name\" : \"$name\",\"middle_name\" : \"$middle_name\",\"code\" : \"$code\"}}');
    final res = await file.readAsString();
    print("created json: $res");

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

  Widget build(BuildContext context) {
    print('LoginPage');
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: Scaffold(
        backgroundColor: Colors.white,
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