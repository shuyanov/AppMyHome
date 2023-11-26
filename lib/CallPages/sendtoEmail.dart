import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Chats/Data/Admin.dart';
import '../Styles/Colors.dart';

class sendtoEmail extends StatefulWidget {
  const sendtoEmail({super.key});

  @override
  State<sendtoEmail> createState() => _sendtoEmailState();
}

class _sendtoEmailState extends State<sendtoEmail> {
  bool? connect;
  @override
  void initState() {
    print("Количество запросов: $countSendEmail");
    connectCheck();
  }

  Future connectCheck() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connect = true;
      }
    } catch (_) {
      connect = false;
      print("Ошибка! Нет интернета: ${_}");
    }
  }

  String email = "";
  String name = "";
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  String message = "";
  final TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        backgroundColor: purpleColor,
        title: Text("Запрос на добавление телефонного номера"),
      ),
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: purpleColor,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TextFormField(
                    controller: nameController,
                    cursorColor: purpleColor,
                    decoration: InputDecoration(
                      labelText: 'От кого?',
                      hintText: 'Введите название организации',
                      labelStyle: TextStyle(
                        color: purpleColor,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: purpleColor),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: purpleColor),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  TextFormField(
                    controller: emailController,
                    cursorColor: purpleColor,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      labelStyle: TextStyle(
                        color: purpleColor,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: purpleColor),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: purpleColor),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  TextFormField(
                    controller: messageController,
                    maxLines: 10,
                    cursorColor: purpleColor,
                    decoration: InputDecoration(
                      labelText: 'Письмо-запрос',
                      hintText:
                          'Введите полную информацию о вашей организации, местоположение и телефонные номера, чтобы вам смогли связаться жители',
                      labelStyle: TextStyle(
                        color: purpleColor,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: purpleColor),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: purpleColor),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(purpleColor),
                          ),
                          onPressed: () async {
                            String subject = "Запрос на добавление телефонных номеров от ${nameController.text}";
                            if (connect == true) {
                              if (countSendEmail != 1) {
                                sendEmail(
                                    name: nameController.text,
                                    email: emailController.text,
                                    subject: subject,
                                    message: messageController.text);
                                countSendEmail = 1;
                                return showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text("Информация"),
                                          content: Text(
                                              "Запрос отправлен. В течение трёх дней ваш запрос будет принят или отклонен. Следите за новостями в электронной почте."),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                },
                                                child: Text('ОК', style: TextStyle(color: purpleColor),))
                                          ],
                                        ));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "Более одного запроса за сегодняшний день сделать нельзя!")));
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Запрос не выполнен.\nНет подключения к интернету")));
                            }
                          },
                          child: Text("Отправить запрос", style: TextStyle(fontSize: 18),))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    String serviceId = 'service_fv5m8sb';
    String templateId = 'template_d43vlxf';
    String userId = 'b90ukqwzUfEoXIQ8l';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_subject': subject,
            'user_name': name,
            'user_email': email,
            'message': message,
          }
        }));
    print(response.body);
  }
}
