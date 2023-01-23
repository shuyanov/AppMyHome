class TaskModel {
  String nameTask;
  String description;
  DateTime date;
  DateTime period;
  bool isCompleted;
  bool isDone;

  TaskModel(
      {required this.nameTask,
      required this.description,
      required this.date,
      required this.period,
      required this.isCompleted,
      required this.isDone});
}
