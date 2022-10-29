import 'package:command_flutter/RegisterPage.dart';
import 'package:command_flutter/main.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String email = "";
  String password = "";


  @override
////////////////////
  Widget _logo(){
    return Padding(
      padding: EdgeInsets.only(top: 100),
      child: Container(
        child: Align(
          child: Text("My House", style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white),),
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
                height: 50,
                width: 100,
                child: _logButton(),
                //_button(),
              ),
              padding: EdgeInsets.only(left: 20,right: 20,)
          ),

        ],
      ),
    );
  }
  ///////////////////
  Widget _regButton(){

    return Container(
        child:  MaterialButton(
            splashColor: Colors.cyan,
            highlightColor: Colors.cyan,
            color: Colors.white,

            child:  Text(
                style: TextStyle( fontWeight: FontWeight.bold, color: Colors.cyan, fontSize: 20),
                'REGISTER'
            ),
            onPressed: (){ print('tap-tap'); return runApp(RegisterPage());  }
    )
    );
  }
  //////////////////

  /////////////////
  Widget _logButton(){
    return Container(
      child:  MaterialButton(
        splashColor: Colors.cyan,
        highlightColor: Colors.cyan,
        color: Colors.white,

        child:  Text(
            style: TextStyle( fontWeight: FontWeight.bold, color: Colors.cyan, fontSize: 20),
            'Log in'
        ),
        onPressed: (){
          funcPress();
        }
    )
    );
  }
  /////////

  ////////
  void funcPress(){
    email = emailController.text;
    password = passwordController.text;
    print("data:   login = ${email} password = ${password}");

    emailController.clear();
    passwordController.clear();
    return runApp(MyApp());
  }
//////////////////
  Widget _input(Icon icon, String hint, TextEditingController controller, bool hidden){
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20),
      child: TextField(
        controller: controller,
        obscureText:  hidden,
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
    return MaterialApp( home:  Scaffold(
      backgroundColor: Colors.cyan,
      body: Column(
        children: <Widget>[
          _logo(),
          _form(),
          _regButton(),
        ],
      ),
    ),
    );
  }
}
