import 'dart:convert';

import 'package:command_flutter/ProfileCom/data/profileData.dart';
import 'package:http/http.dart' as http;

import '../model/historyTask.dart';
import '../model/task.dart';

var getResApi;
bool isData = false;

Future GetRequest() async {
  try {
    String uri = "http://185.231.155.185/api/getRequest.php";
    var res = await http.post(Uri.parse(uri), body: {
      "UK": "Шереметьевская миля",
      // "TYPE": "отопление",
      "FIRST": "0",
      "LAST": "1000",
      "ALL": "true",
    });
    // var response = jsonDecode(res.body);
    if (res.statusCode == 200) {
      isData = true;
      getResApi = TaskFromJson(res.body);
      print("GetRequest: ${res.statusCode}\n${getResApi[1].id}");
    } else {
      print("not GetRequest");
    }
    // return response;
    // print("GetRequest: ${response}");
  } catch (e) {
    print("excep GetRequest = $e");
  }
}


bool isDataHis = false;
var getResHis;

Future<void> GetRequestHistory() async {
  try {
    String uri = "http://185.231.155.185/api/getRequestHistory.php";
    var res = await http.post(Uri.parse(uri), body: {
      // "SURNAME": "Виноградов",
      // "NAME": "Никита",
      "SURNAME": profiles[indexProfile].surname.toString(),
      "NAME": profiles[indexProfile].name.toString(),
      "FIRST": "0",
      "LAST": "1000",
    });
    // var response = jsonDecode(res.body);
    if (res.statusCode == 200) {
      getResHis = historyTasksFromJson(res.body);
      isDataHis = true;
      print("GetRequestHistory: ${res.statusCode}");
    } else {
      print("not GetRequestHistory");
    }
    // print("GetRequestHistory: ${response}");
  } catch (e) {
    print("excep GetRequestHistory = $e");
  }
}



bool isDataInWork = false;
var getResInWork;

Future<void> GetRequestInWork() async {
  try {
    String uri = "http://185.231.155.185/api/getRequestInWork.php";
    var res = await http.post(Uri.parse(uri), body: {
      // "SURNAME": "Виноградов",
      // "NAME": "Никита",
      "SURNAME": profiles[indexProfile].surname.toString(),
      "NAME": profiles[indexProfile].name.toString(),
      "FIRST": "0",
      "LAST": "1000",
    });
    // var response = jsonDecode(res.body);
    if (res.statusCode == 200) {
      getResInWork = historyTasksFromJson(res.body);
      isDataInWork = true;
      print("getRequestInWork: ${res.statusCode}");
    } else {
      print("not getRequestInWork");
    }
    // print("getRequestInWork: ${response}");
  } catch (e) {
    print("excep getRequestInWork = $e");
  }
}


// bool isDataCloseRequest = false;
// var getResCloseRequest;

Future<void> CloseRequest(String id) async {
  try {
    String uri = "http://185.231.155.185/api/closeRequest.php";
    var res = await http.post(Uri.parse(uri), body: {
      // "SURNAME": "Виноградов",
      // "NAME": "Никита",
      "SURNAME": profiles[indexProfile].surname.toString(),
      "NAME": profiles[indexProfile].name.toString(),
      "ID": id,
      // "LAST": "1000",
    });
    var response = jsonDecode(res.body);
    if (res.statusCode == 200) {
      // isDataCloseRequest = historyTasksFromJson(res.body);
      // getResCloseRequest = true;
      print("closeRequest: ${res.statusCode}");
    } else {
      print("not closeRequest");
    }
    print("closeRequest: ${response}");
  } catch (e) {
    print("excep closeRequest = $e");
  }
}



Future<void> TakeRequest(int id) async {
  try {
    String uri = "http://185.231.155.185/api/takeRequest.php";
    var res = await http.post(Uri.parse(uri), body: {
      // "SURNAME": "Виноградов",
      // "NAME": "Никита",
      "SURNAME": profiles[indexProfile].surname.toString(),
      "NAME": profiles[indexProfile].name.toString(),
      "ID": id,
      // "LAST": "1000",
    });
    var response = jsonDecode(res.body);
    if (res.statusCode == 200) {
      // isDataCloseRequest = historyTasksFromJson(res.body);
      // getResCloseRequest = true;
      print("takeRequest: ${res.statusCode}");
    } else {
      print("not takeRequest");
    }
    // print("takeRequest: ${response}");
  } catch (e) {
    print("excep takeRequest = $e");
  }
}