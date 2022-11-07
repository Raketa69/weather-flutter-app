import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internship/pages/home_page.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(fontFamily: 'Roboto'),
      dark: ThemeData(fontFamily: 'Roboto'),
      initial: AdaptiveThemeMode.light,
      builder: (light, dark) => MaterialApp(
        theme: light,
        darkTheme: dark,
        title: 'WeatherApp',
        home: HomePage(),
      ),
    );
  }
}
