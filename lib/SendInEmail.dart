import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'dart:async';
import 'package:flutter/services.dart';
import '../Utils/UserPerefer.dart';


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
      UsersedTest nikita = UsersedTest.fromJson(json['user']);
      print("code = ${nikita.code}");
      print("email");

      Timer(Duration(milliseconds: 50), () {
        email = nikita.adminEmail;
        name = nikita.name;
        print("email");
        print(email);
      });
    }

    getUserTesta();
    print("Test");
    Timer(Duration(milliseconds: 100), () {
      subject = subjectController.text;
      message = messageController.text;

      sendEmail( subject: subject, message: message);
      subjectController.clear();
      messageController.clear();


      // print(
      //     "name = $name | email = $email | subject = $subject | message = $message");
      // print("object");

      if(email==""||email=="no"){
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
            margin: EdgeInsets.only(top: 1),
            height: 36,
            width: 170,
        child:
        ElevatedButton(
          child: Text("Отправить", style: TextStyle(color: Colors.white, fontSize: 26)),
          onPressed: () => funcPress(),
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(200, 158, 122, 244),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
          /*style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.cyan,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),*/
        )
    );
  }
//////////////////////
  /*Widget _input(Icon icon, String hint, TextEditingController controller, bool hidden){
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
  }*/
  Widget _input(Icon icon, String hint, TextEditingController controller, bool hidden){
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20),
      child: TextField(
        controller: controller,
        obscureText: hidden,
        style: TextStyle(fontSize: 20, color: Color.fromARGB(200, 255, 255, 255)),
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(200, 92, 96, 196),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0)),
          hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white60),
          hintText: hint,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(200, 92, 96, 196), width: 0),
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
    return ListView(
      children: [
        Column(
          children: [

            SizedBox(height: 330),
            Padding( padding: EdgeInsets.only(bottom: 20),child: Text("Обращение в УК",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35),)),
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: _input(Icon(Icons.text_snippet), "Тема обращения", subjectController, false),
                )
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20,),
              child: _input(Icon(Icons.mail), "Сообщение", messageController, false),
            ),
            SizedBox(height: 15),
            Center(
              child: Padding(
                  child: Container(
                    height: 60,
                    width: 170,
                    child: _logButton(),

                  ),
                  padding: EdgeInsets.only(left: 20,right: 20,bottom: 10 )
              ),
            ),
          ],
        )
      ],
    );
  }
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home:  Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [

              Container(
                child: Stack(
                children: [
                  Image.asset('assets/profile/profileBackground.jpg', width: 1000,fit:BoxFit.fill),
                  Image.asset('assets/mainLogo.png',width: 1000, fit:BoxFit.fill),
                  ],
                  )
                ),
              _form(),
            ],
          )
        )
    );
  }
}
