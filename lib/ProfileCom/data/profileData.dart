import 'package:command_flutter/ProfileCom/model/profile.dart';

import '../model/task.dart';

List<ProfileModel> profiles = [
  ProfileModel(name: "Иванов Иван Иванович", job: "Слесарь", tasks: [
    TaskModel(
        nameTask: "nameTask1",
        description: "description1",
        date: DateTime.now(),
        period: DateTime.parse("20230123"),
        isCompleted: true,
        isDone: true),
    TaskModel(
        nameTask: "nameTask2",
        description: "description2",
        date: DateTime.now(),
        period: DateTime.parse("20230125"),
        isCompleted: true,
        isDone: true),
    TaskModel(
        nameTask: "nameTask3",
        description: "description3",
        date: DateTime.now(),
        period: DateTime.parse("20230204"),
        isCompleted: true,
        isDone: false),
    TaskModel(
        nameTask: "nameTask4",
        description: "description4",
        date: DateTime.now(),
        period: DateTime.parse("20230205"),
        isCompleted: true, 
        isDone: false),
    TaskModel(
        nameTask: "nameTask5",
        description: "description5",
        date: DateTime.now(),
        period: DateTime.parse("20230206"),
        isCompleted: true,
        isDone: false,),
    TaskModel(
        nameTask: "nameTask6",
        description: "description6",
        date: DateTime.now(),
        period: DateTime.parse("20230207"),
        isCompleted: false,
        isDone: false),
    TaskModel(
        nameTask: "nameTask7",
        description: "description7",
        date: DateTime.now(),
        period: DateTime.parse("20230208"),
        isCompleted: false,
        isDone: false,),
    TaskModel(
        nameTask: "nameTask8",
        description: "description8",
        date: DateTime.now(),
        period: DateTime.parse("20230209"),
        isCompleted: false,
        isDone: false,),
    TaskModel(
        nameTask: "nameTask9",
        description: "description9",
        date: DateTime.now(),
        period: DateTime.parse("20230210"),
        isCompleted: false,
        isDone: false,),
  ]),
  ProfileModel(name: "Петров Петр Петрович", job: "Сантехник", tasks: [
    TaskModel(
        nameTask: "nameTask1",
        description: "description1",
        date: DateTime.parse("20230101"),
        period: DateTime.parse("20230102"),
        isCompleted: true,
        isDone: true,),
    TaskModel(
        nameTask: "nameTask2",
        description: "description2",
        date: DateTime.parse("20230102"),
        period: DateTime.parse("20230103"),
        isCompleted: true,
        isDone: true,),
    TaskModel(
        nameTask: "nameTask3",
        description: "description3",
        date: DateTime.parse("20230103"),
        period: DateTime.parse("20230104"),
        isCompleted: true,
        isDone: true,),
    TaskModel(
        nameTask: "nameTask4",
        description: "description4",
        date: DateTime.parse("20230104"),
        period: DateTime.parse("20230105"),
        isCompleted: true,
        isDone: false,),
    TaskModel(
        nameTask: "nameTask5",
        description: "description5",
        date: DateTime.parse("20230105"),
        period: DateTime.parse("20230106"),
        isCompleted: true,
        isDone: false,),
    TaskModel(
        nameTask: "nameTask6",
        description: "description6",
        date: DateTime.parse("20230106"),
        period: DateTime.parse("20230107"),
        isCompleted: true,
        isDone: false,),
    TaskModel(
        nameTask: "nameTask7",
        description: "description7",
        date: DateTime.parse("20230107"),
        period: DateTime.parse("20230108"),
        isCompleted: true,
        isDone: false,),
    TaskModel(
        nameTask: "nameTask8",
        description: "description8",
        date: DateTime.parse("20230108"),
        period: DateTime.parse("20230109"),
        isCompleted: false,
        isDone: false,),
    TaskModel(
        nameTask: "nameTask9",
        description: "description9",
        date: DateTime.parse("20230109"),
        period: DateTime.parse("20230110"),
        isCompleted: false,
        isDone: false,),
  ])
];
