import 'package:command_flutter/Styles/Colors.dart';
import 'package:flutter/material.dart';

class Themes {
  static final dark = ThemeData(
    // brightness: Brightness.dark,
    appBarTheme: AppBarTheme(backgroundColor: Colors.grey.shade900),
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.white,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.white),
    switchTheme: SwitchThemeData(
      thumbColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return purpleColor;
        }
        return Colors.white;
      }),
      trackColor: MaterialStateProperty.all(purpleColor.withOpacity(0.2)),
    ),
  );
  static final light = ThemeData(
    // brightness: Brightness.light,
    appBarTheme: AppBarTheme(backgroundColor: purpleColor),
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.black,
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.grey[800]),
    switchTheme: SwitchThemeData(
      thumbColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return purpleColor;
        }
        return Colors.white;
      }),
      trackColor: MaterialStateProperty.all(purpleColor.withOpacity(0.2)),
    ),
  );
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  bool get isDarkMode => themeMode == ThemeMode.dark;
  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
  // bool isOn = false;

  // ThemeData get currentTheme => isOn ? Themes.dark : Themes.light;
  // toggleTheme() {
  //   isOn = !isOn;
  //   notifyListeners();
  // }
}
