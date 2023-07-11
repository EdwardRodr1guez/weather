import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/backend/apis/open_weather_service.dart';
import 'package:weather/provider/favorites_provider.dart';

import 'package:weather/screens/weather_screen.dart';
import 'package:weather/config/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //ensure the app is corrected initialized
  runApp(const MyApp()); //Run the app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /*
  This widget is the root of your application. Material app wraps
  the entire application. WeatherScreen is a default page. 

  Multiprovider allow listens for changes in all the application,
  openweatherservice for fetching weather and favoritesprovider to handle favorite cities of the user
  */

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OpenWeatherService()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Weather',
          theme: AppTheme().getTheme(),
          home: const WeatherScreen()),
    );
  }
}
