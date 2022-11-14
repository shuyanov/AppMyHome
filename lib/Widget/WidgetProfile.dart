import 'dart:convert';
import 'dart:io';

import 'package:command_flutter/Pages/EditProfilePage.dart';
import 'package:command_flutter/Utils/UserPerefer.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'ProfileWidget.dart';

class WidgetProfileName extends StatefulWidget {
  const WidgetProfileName({Key? key}) : super(key: key);

  @override
  State<WidgetProfileName> createState() => _WidgetProfileNameState();
}

class _WidgetProfileNameState extends State<WidgetProfileName> {
  String name = "";
  String surName = "";

  @override
  void initState() {
    _GetDataFromJson();
    super.initState();

    print(name);
    print(surName);
  }
  void _GetDataFromJson() async{
    final directory = await pathProvider.getApplicationSupportDirectory();
    final fileDirectory = directory.path + '/datas.json';
    final file = File(fileDirectory);

    final json = jsonDecode(await file.readAsString());

    var UserActual = new Usersed.fromJson(json['user']);

    name = UserActual.login;
    surName = UserActual.surname;
  }

  @override
  Widget build(BuildContext context) {
    final user = UserPereferences.myUser;

    return Padding( padding: const EdgeInsets.all(30),
        child: Align(
          alignment: Alignment.topLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 1,
                child: ProfileWidget(
                  imagePatch: user.imagePath,
                  onCliced: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => EditProfilePage())
                    );
                  },
                ),
              ),
              Expanded(
                flex:  2,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Text(name, style: TextStyle(fontSize: 26)),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.only(top: 40, left: 20),
                      child: Text("SurName", style: TextStyle(fontSize: 16, color: Colors.grey),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
