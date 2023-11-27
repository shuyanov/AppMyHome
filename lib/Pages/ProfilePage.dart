import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/Chats/api/firebase.dart';
import '/ProfileCom/personalPage.dart';
import '../CallPages/CallPage.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as pathProvider;

import '../Login/LOginPage.dart';
import '../ProfileCom/requestsPage.dart';
import '../SendInEmail.dart';
import '../Utils/UserPerefer.dart';
import '../Widget/ButtonLoginPage.dart';
import '../Widget/ButtonWidget.dart';
import '../Widget/ButtonWidgetProfile.dart';
import '../Widget/WidgetProfile.dart';
import 'EditProfilePage.dart';
import 'TestIcon.dart';

class ProfileePage extends StatefulWidget {
  final user;
  const ProfileePage({required this.user});
  @override
  State<ProfileePage> createState() => _ProfileePageState();
}

class _ProfileePageState extends State<ProfileePage> {

  @override
  void initState() {
    super.initState();
    baseAPI.readAvatar();
    // getAvatar();
  }

  @override
  Widget build(BuildContext context) {

  //   if(!_isLoading)
  //   {
  //     return CircularProgressIndicator();
  //   }
  //   else {
  //     Timer(Duration(seconds: 1), () {
  //       ButtonLoginReg();

  //     });
  //     setState(() {});
  // }
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: /* ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: purpleColor, // меняет цвет при прокрутке */
                 Container(child: buildProfilewidget(widget.user)),
          // ),
        // ),
      );
    }

  Widget buildProfilewidget(var user)
  {
    setState(() {});
    Size size = MediaQuery.of(context).size;
    return Stack(
          children: <Widget>
          [
            Container(
              child: Stack(
                children: [
                  Image.asset(
                      'assets/profile/profileBackground.jpg', width: size.width,
                      fit: BoxFit.fill),
                  Image.asset(
                      'assets/profile/GroundUpBar.png',  width: size.width,
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
                        WidgetProfileName(user: user,),
                      ],
                    )
                ),
                SizedBox(height: size.height / 8),
                //Button
                Padding(
                  padding: EdgeInsets.only(
                      left: 20, right: 20, bottom: 0),
                  child: Container(
                    height: 40,
                    width: size.width,
                    child: buildPersonalBillButton(),
                  ),
                ),
                ////
                SizedBox(height: 50),
                Container(
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
                      width: size.width,
                      child: build_Setting_Button(),
                    )
                ),
                SizedBox(height: 10),
                Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, bottom: 20),
                    child: Container(
                      height: 40,
                      width: size.width,
                      child: buildExitProfileButton(),
                    )
                ),
              ],
            )
          ],
    );
  }

  Widget buildExitProfileButton() => 
  ElevatedButton(
    style: ElevatedButton.styleFrom(
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),),
      onPrimary: Colors.black,
      backgroundColor: Colors.red[600]
    ),
      onPressed: () {runApp(LoginPage());},
      child: Stack(
      children: [
          Text('Выход', style: TextStyle(fontSize: 21, color: Colors.white)),
          ],
        ),
      );
  // ButtonWidget(
  //   text:'Выход',
  //   onClicked: (){
  //       runApp(LoginPage());
  //     // Navigator.of(context).push(
  //         // MaterialPageRoute(builder: (context) => LoginPage())
  //       // );
  //     },
  //   );

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
          MaterialPageRoute(builder: (context) => PersonalPage(user: widget.user))
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
