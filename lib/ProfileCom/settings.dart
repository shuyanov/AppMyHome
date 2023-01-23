import 'dart:ui';
import 'package:command_flutter/main.dart';
import 'package:command_flutter/mainTest.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Login/LOginPage.dart';
import '../Styles/Themes.dart';

class settingsPage extends StatelessWidget {
  const settingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Настройки",
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(
                  MyAppTest.themeNotifier.value == ThemeMode.light
                  // MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Icons.nightlight
                      : Icons.light_mode),
              title: Text(
                  MyAppTest.themeNotifier.value == ThemeMode.light
                  // MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? "Темный режим"
                      : "Светлый режим",
                  style: TextStyle(fontSize: 20)),
              trailing: Switch.adaptive(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    final provider =
                        Provider.of<ThemeProvider>(context, listen: false);
                    provider.toggleTheme(value);
                    MyAppTest.themeNotifier.value = MyAppTest.themeNotifier.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
                  }),
            ),
            ListTile(
              leading: Icon(Icons.info_outlined),
              title: Text("О приложении", style: TextStyle(fontSize: 20)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.help_outline),
              title: Text("Помощь", style: TextStyle(fontSize: 20)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
              title: Text(
                "Выйти",
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
              onTap: () {
                runApp(LoginPage());
              },
            ),
            // ListTile(
            //   leading: ,
            // ),
          ],
        ),
      ),
    );
  }
}
