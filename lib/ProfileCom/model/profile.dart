import 'package:command_flutter/ProfileCom/model/task.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileModel {
  String name;
  String job;
  List<TaskModel> tasks;
  ProfileModel({required this.name, required this.job, required this.tasks});
}
