import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class sendtoEmail extends StatelessWidget {
  const sendtoEmail({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    String email = "";
    String name = "";
    TextEditingController subjectController = TextEditingController();
    TextEditingController messageController = TextEditingController();
    String subject = "";
    String message = "";
    return Scaffold(
      appBar: AppBar(
        title: Text("Запрос на добавление телефонного номера"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            // _input(),
          ],
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
    Widget _input(String hint, TextEditingController controller, bool hidden){
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20),
      child: TextFormField(
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
        ),
      ),
    );
  }
}
