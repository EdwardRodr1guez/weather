import 'package:flutter/material.dart';
import 'package:weather/screens/weather_screen.dart';
import 'package:weather/theme/app_theme.dart';

void main() async {
  //localization permission is requested for fetching data
  runApp(const MyApp()); //Run the app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /*
  This widget is the root of your application. Material app wraps
  the entire application. WeatherScreen is a default page. 
  */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather',
        theme: AppTheme().getTheme(),
        home: const WeatherScreen());
  }
}
