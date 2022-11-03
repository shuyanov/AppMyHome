import 'package:command_flutter/LoginPage.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  String email = "";
  String name = "";
  String middleName = "";
  String surname = "";
  String password = "";
  String code = "";


  @override
////////////////////
  Widget _logo() {
    return Padding(
      padding: EdgeInsets.only(top: 100),
      child: Container(
        child: Align(
          child: Text("DOM", style: TextStyle(
              fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white),),
        ),
      ),
    );
  }

//////////////////
  Widget _form() {
    return SingleChildScrollView(
      child: Column(
        children: [

          Padding(
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: _input(
                Icon(Icons.email), "+7-912-345-67-89", emailController, false),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 20,),
            child: _input(
                Icon(Icons.account_box_rounded), "Ivanov", surnameController, false),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: _input(Icon(Icons.account_box_rounded), "Ivan", nameController, false),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 20,),
            child: _input(
                Icon(Icons.account_box_rounded), "Ivanowich", middleNameController, false),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20, top: 10),
            child: _input(Icon(Icons.lock), "PASSWORD", passwordController, true),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 20,),
            child: _input(Icon(Icons.numbers_outlined), "CODE", codeController, false),
          ),
          SizedBox(height: 20,),
          Padding(
              child: Container(
                height: 50,
                width: 100,
                child: _regButton(),
                //_button(),
              ),
              padding: EdgeInsets.only(left: 20, right: 20,)
          ),

        ],
      ),

    );
  }

  ///////////////////
  Widget _logPageButton() {
    return Container(
        child: MaterialButton(
            splashColor: Colors.cyan,
            highlightColor: Colors.cyan,
            color: Colors.white,

            child: Text(
                style: TextStyle(fontWeight: FontWeight.bold,
                    color: Colors.cyan,
                    fontSize: 20),
                'LOG IN'
            ),
            onPressed: () {
              print('tap-tap');
              return runApp(LoginPage());
            }
        )
    );
  }

  //////////////////

  /////////////////
  Widget _regButton() {
    return Container(
        child: MaterialButton(
            splashColor: Colors.cyan,
            highlightColor: Colors.cyan,
            color: Colors.white,

            child: Text(
                style: TextStyle(fontWeight: FontWeight.bold,
                    color: Colors.cyan,
                    fontSize: 20),
                'REGISTER'
            ),
            onPressed: () {
              funcPress();
            }
        )
    );
  }

<<<<<<< Updated upstream
  /////////

  ////////
  void funcPress() {
=======
/////////
  String encoding(String value){
    var byte = utf8.encode(value);
    var digest = sha256.convert(byte);
    return digest.toString();
  }
////////
  void funcPress() async {
>>>>>>> Stashed changes
    email = emailController.text;
    password = passwordController.text;
    code = codeController.text;
    name = nameController.text;
    surname = surnameController.text;
    middleName = middleNameController.text;

<<<<<<< Updated upstream
    print("data:   login = ${email} surname = ${surname} name = ${name} middle_Name = ${middleName} password = ${password} code = ${code}");
=======
    if(email == "" || password == "" || code == "" || name == "" || surname == "" || middleName == "" ){
      Fluttertoast.showToast(
          msg: "Error! Wrong login or password, try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb:
          1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return ;
    }

////////////////////
    void PushToJson(String login, String password, String surname, String name, String middle_name, String code) async {

      final directory = await pathProvider.getApplicationSupportDirectory();
      final fileDirectory = directory.path + '/datas.json';
      final file = File(fileDirectory);
      await file.writeAsString('{\"user\": {\"login\" : \"$login\"\,\"password\" : \"$password\",\"surname\" : \"$surname\",\"name\" : \"$name\",\"middle_name\" : \"$middle_name\",\"code\" : \"$code\"}}');
      final res = await file.readAsString();
      print("created json: $res");

    }
////////////////

    print("Connecting to mysql server...");
// create connection
    final conn = await MySQLConnection.createConnection(
      host: "185.231.155.185",
      port: 3306,
      userName: "appUser",
      password: "123879",
      databaseName: "data", // optional
    );
    await conn.connect();
    print("Connected");
// make query
    var result = await conn.execute("SELECT * FROM user");
>>>>>>> Stashed changes

    emailController.clear();
    passwordController.clear();
    nameController.clear();
    codeController.clear();
    surnameController.clear();
    middleNameController.clear();

  }

//////////////////
  Widget _input(Icon icon, String hint, TextEditingController controller,
      bool hidden) {
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20),
      child: TextField(
        controller: controller,
        obscureText: hidden,
        style: TextStyle(fontSize: 20, color: Colors.white),
        decoration: InputDecoration(
          hintStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white30),
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
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.cyan,
        body:
        SingleChildScrollView(child: Column(
          children: <Widget>[
            _logo(),
            _form(),
            _logPageButton(),
          ],
        ),
        ),
      ),
    );
  }
}