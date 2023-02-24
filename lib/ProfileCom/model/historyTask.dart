// To parse this JSON data, do
//
//     final historyTasks = historyTasksFromJson(jsonString);

import 'dart:convert';

List<HistoryTask> historyTasksFromJson(String str) => List<HistoryTask>.from(json.decode(str).map((x) => HistoryTask.fromJson(x)));

String historyTasksToJson(List<HistoryTask> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryTask {
    HistoryTask({
        this.count,
        required this.id,
        required this.data,
        required this.uk,
        required this.type,
        required this.message,
        required this.address,
        required this.phone,
        required this.userId,
        required this.status,
    });

    String? count;
    String? id;
    String? data;
    String? uk;
    String? type;
    String? message;
    String? address;
    String? phone;
    String? userId;
    String? status;

    factory HistoryTask.fromJson(Map<String, dynamic> json) => HistoryTask(
        count: json["count"],
        id: json["id"],
        data: json["data"],
        uk: json["uk"],
        type: json["type"],
        message: json["message"],
        address: json["address"],
        phone: json["phone"],
        userId: json["user_id"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "id": id,
        "data": data,
        "uk": uk,
        "type": type,
        "message": message,
        "address": address,
        "phone": phone,
        "user_id": userId,
        "status": status,
    };
}
