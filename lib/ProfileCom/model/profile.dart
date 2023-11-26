import 'task.dart';

class ProfileModel {
  String surname;
  String name;
  String job;
  List<Task> tasks;
  ProfileModel({required this.surname, required this.name, required this.job, required this.tasks});
}
