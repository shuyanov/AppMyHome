import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'dart:async';
import 'package:flutter/services.dart';
import '../Utils/UserPerefer.dart';

//ad dependencies:
//   http: ^0.13.5


class Send extends StatelessWidget {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String email = "";
  String name = "";
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  String subject = "";
  String message = "";

/////////////////
    funcPress() {
    void getUserTesta() async {
      final directory = await pathProvider.getApplicationSupportDirectory();
      final fileDirectory = directory.path + '/datasTest.json';
      final file = File(fileDirectory);
      final json = jsonDecode(await file.readAsString());

      print(json);
      Usersed nikita = Usersed.fromJson(json['user']);
      print("code = ${nikita.code}");
      print("email");

      Timer(Duration(seconds: 1), () {
        email = nikita.login;
        name = nikita.name;
        print("email");
        print(email);
      });
    }

    getUserTesta();
    print("Test");
    Timer(Duration(seconds: 2), () {
      subject = subjectController.text;
      message = messageController.text;

      sendEmail( subject: subject, message: message);
      subjectController.clear();
      messageController.clear();


      // print(
      //     "name = $name | email = $email | subject = $subject | message = $message");
      // print("object");

      if(email==""){
        Fluttertoast.showToast(
            msg: "Отправка обращения невозможна, обратитесь к руководителю ТСЖ для добавления адреса получателя",
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

    });
  }
///////////////////
  Widget _logButton(){
    return Container(
        child:
        ElevatedButton(
          child: Text("Send", style: TextStyle(color: Colors.cyan, fontSize: 26)),
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
//////////////////////
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
////////////
  Future sendEmail({
    required String subject,
    required String message,
  })
    async{
    final serviceId = 'service_gncc96m';
    final templateId = 'template_k23j3e9';
    final userId = 'DfFoFybo_xO5kSEYV';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'Content-Type':'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id':userId,
        'template_params':{
          'user_name': name,
          'user_email': email,
          'user_subject':subject,
          'user_message':message,
        }
      }),
    );
    print(response.body);
  }
//////////
  Widget _form(){
    return Container(
      padding: EdgeInsets.only(top: 150),
      child: Column(
        children: [
          // Padding(
          //   padding: EdgeInsets.only(bottom: 20, top: 10),
          //   child: _input(Icon(Icons.email), "name", nameController, false),
          // ),
          // Padding(
          //   padding: EdgeInsets.only(bottom: 20,),
          //   child: _input(Icon(Icons.lock), "email", emailController, false),
          // ),
          Padding(
            padding: EdgeInsets.only(bottom: 20,),
            child: _input(Icon(Icons.lock), "subject", subjectController, false),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20,),
            child: _input(Icon(Icons.lock), "message", messageController, false),
          ),
          SizedBox(height: 100),
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home:  Scaffold(
          backgroundColor: Colors.orange,
          body: _form(),
        )
    );
  }
}
