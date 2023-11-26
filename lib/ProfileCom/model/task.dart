// To parse this JSON data, do
//
//     final task = taskFromJson(jsonString);

import 'dart:convert';

List<Task> taskFromJson(String str) => List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));

String taskToJson(List<Task> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Task {
    String id;
    DateTime data;
    String type;
    String message;
    String address;
    String phone;
    String userId;
    String status;

    Task({
        required this.id,
        required this.data,
        required this.type,
        required this.message,
        required this.address,
        required this.phone,
        required this.userId,
        required this.status,
    });

    factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        data: DateTime.parse(json["data"]),
        type: json["type"],
        message: json["message"],
        address: json["address"],
        phone: json["phone"],
        userId: json["userId"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "data": "${data.year.toString().padLeft(4, '0')}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}",
        "type": type,
        "message": message,
        "address": address,
        "phone": phone,
        "userId": userId,
        "status": status,
    };
}
