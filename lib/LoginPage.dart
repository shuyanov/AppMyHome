import 'package:flutter/material.dart';
import 'package:hackaton/screens/HomePage.dart';
import 'package:hackaton/screens/RegisterPage.dart';
import 'package:fluttertoast/fluttertoast.dart';


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
          child: Text("DOM DOMYCH", style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white),),
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
                height: 60,
                width: 150,
                child: _logButton(),
                //_button(),
              ),
              padding: EdgeInsets.only(left: 20,right: 20,bottom: 10 )
          ),

        ],
      ),
    );
  }
  ///////////////////

  ///////////////////
  Widget _regButton(){

    return Container(
        margin: EdgeInsets.only(top: 6),
        height: 42,
        width: 110,
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
    email = emailController.text;
    password = passwordController.text;
    print("data:   login = ${email} password = ${password}");
    if(email == "123" && password == "321"){
      return runApp(HomePage());
    }
    else{
      Fluttertoast.showToast(
          msg: "Error! Wrong login or password, try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    emailController.clear();
    passwordController.clear();
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
    print('LoginPage');
    return MaterialApp( home:  Scaffold(
      backgroundColor: Colors.cyan,
      body:
        SingleChildScrollView(
           child:    Column(
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
