import 'dart:async';
import 'dart:convert';
import 'package:command_flutter/Chats/api/firebase.dart';
import 'package:command_flutter/Pages/TestIcon.dart';
import 'package:command_flutter/SendInEmail.dart';
import 'package:command_flutter/Utils/UserPerefer.dart';
import 'package:command_flutter/Widget/ButtonLoginPage.dart';
import 'package:command_flutter/Widget/ButtonWidgetProfile.dart';
import 'package:command_flutter/Widget/WidgetProfile.dart';
import 'package:command_flutter/Login/LOginPage.dart';
import 'package:command_flutter/Pages/EditProfilePage.dart';
import 'package:command_flutter/Widget/ButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../CallPages/CallPage.dart';
import '../Styles/Colors.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as pathProvider;

class ProfileePage extends StatefulWidget {
  const ProfileePage({Key? key}) : super(key: key);
  @override
  State<ProfileePage> createState() => _ProfileePageState();
}

class _ProfileePageState extends State<ProfileePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    baseAPI.readAvatar();
    // getAvatar();
  }

  @override
  Widget build(BuildContext context) {

    if(!_isLoading)
    {
      return CircularProgressIndicator();
    }
    else {
      Timer(Duration(seconds: 1), () {
        ButtonLoginReg();

      });
      setState(() {});
      return ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: purpleColor, // меняет цвет при прокрутке
          child: ListView(
            children: [
              buildProfilewidget()
            ],
          ),
        ),
      );
    };
  }

  Widget buildProfilewidget()
  {
    setState(() {});
    return new Stack(
          children: <Widget>
          [
            Container(
              child: Stack(
                children: [
                  Image.asset(
                      'assets/profile/profileBackground.jpg', width: 1000,
                      fit: BoxFit.fill),
                  Image.asset(
                      'assets/profile/GroundUpBar.png', width: 1000,
                      fit: BoxFit.fill),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                    child: Stack(
                      children: [
                        WidgetProfileName(),
                      ],
                    )
                ),
                SizedBox(height: 90),
                //Button
                Padding(
                  padding: EdgeInsets.only(
                      left: 20, right: 20, bottom: 0),
                  child: Container(
                    height: 40,
                    width: 330,
                    child: buildPersonalBillButton(),
                  ),
                ),
                ////
                SizedBox(height: 50),
                Center(
                  child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                child: Stack(
                                  children: [
                                    build_UK_Button(),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text("УК", style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey)),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 30),
                          Container(
                            height: 80,
                            width: 80,
                            child: Stack(
                              children: [
                                build_Problem_Button(),
                                Align(alignment: Alignment.bottomCenter,
                                  child: Text("Проблема",
                                      style: TextStyle(fontSize: 14,
                                          color: Colors.grey)),
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 30),
                          Container(
                            height: 80,
                            width: 80,
                            child: Stack(
                              children: [
                                build_worker_Button(),
                                Align(alignment: Alignment.bottomCenter,
                                  child: Text("Службы", style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                  ),
                ),
                SizedBox(height: 30),
                ////
                Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, bottom: 10),
                    child: Container(
                      height: 40,
                      width: 330,
                      child: build_Setting_Button(),
                    )
                ),
                SizedBox(height: 10),
                Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, bottom: 10),
                    child: Container(
                      height: 40,
                      width: 330,
                      child: buildExitProfileButton(),
                    )
                ),
              ],
            )
          ],
    );
  }

  Widget buildExitProfileButton() => ButtonWidget(
    text:'Выход',
    onClicked: (){
        runApp(LoginPage());
      // Navigator.of(context).push(
          // MaterialPageRoute(builder: (context) => LoginPage())
        // );
      },
    );

  Widget buildEditProfileButton() => ButtonWidget(
    text:'Редактировать',
    onClicked: (){
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EditProfilePage())
      );
    },
  );

  Widget buildPersonalBillButton() => ButtonWidget(
    text:'Лицевой Счёт',
    onClicked: () async{
      final directory = await pathProvider.getApplicationSupportDirectory();
      final fileDirectory = directory.path + '/datasTest.json';
      final file = File(fileDirectory);
      final json = jsonDecode(await file.readAsString());
      UsersedTest nikita = UsersedTest.fromJson(json['user']);

      Clipboard.setData(new ClipboardData(text: nikita.personalCheck)).then((_){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content:Text(nikita.personalCheck)));
      });
    },
  );
    ////
  Widget build_UK_Button() => ButtonWidgetProfile(
    imagees: "assets/profile/Massage.png",
    onClicked: (){
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Send())
      );
    },
  );

  Widget build_Problem_Button() => ButtonWidgetProfile(
    imagees: "assets/profile/SosButton.png",
    onClicked: (){
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HomeViewTest())
      );
    },
  );

  Widget build_worker_Button() => ButtonWidgetProfile(
      imagees: "assets/profile/iconMan.png",
    onClicked: (){
      ButtonLoginReg();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CallPage())
      );
    },
  );

  Widget build_Setting_Button() => ButtonWidget(
    text:'Настройки',
    onClicked: (){
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EditProfilePage())
      );
    },
  );

  }
