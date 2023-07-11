import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather/backend/apis/location_service.dart';
import 'package:weather/backend/apis/open_weather_service.dart';

import 'package:weather/screens/main_weather_screen.dart';
import 'package:weather/screens/onboarding_screen.dart';

/*
It contains an onboarding (loader screen)
which is shown when the weather data is being fetched.

When fetching is completed the user is redirected to the main view.
*/

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  //stateful variables to handle fetch request events and loading screen
  bool isLoadingScreen = true;
  bool isWeatherFetched = false;

  @override
  void initState() {
    super.initState();
    _handleLocationPermission();
  }

  /*when conditions are met, the user is redirected to MainWeather screen
    *OnboardingScreen: is the loading screen, the location permission are checked and updated
    *MainweatherScreen: is a pageview, with two views, first, for visualize climate now and forecasting and the second, the favorites section.
  */

  @override
  Widget build(BuildContext context) {
    return isLoadingScreen & !isWeatherFetched
        ? const OnboardingScreen()
        : const MainWeatherScreen();
  }

  /*_handleLocationpermission is a function which check and update location permissions.
    this function consist of three steps:
    1) check location permissions
    2) if yes, the current location is storaged and the current and forecasted weather is computed.
    3) if no, none coordinates are storaged and the process of fetching data is finished.
        Notice, whatever be the location permission, the user is sent to MainweatherScreen
  */

  Future _handleLocationPermission() async {
    await Future.delayed(const Duration(seconds: 3));
    final permissionStatus =
        await LocationService.handleLocationPermission(context);

    if (permissionStatus) {
      final Position position = await Geolocator.getCurrentPosition();
      String lat = position.latitude.toString();
      String lon = position.longitude.toString();

      await Provider.of<OpenWeatherService>(context, listen: false)
          .getClimateNow(lat: lat, lon: lon);
      await Provider.of<OpenWeatherService>(context, listen: false)
          .getClimateForecast(lat: lat, lon: lon);
      isWeatherFetched = true;
      await Future.delayed(const Duration(milliseconds: 4000));
    } else {
      Provider.of<OpenWeatherService>(context, listen: false).latitude = "";
      Provider.of<OpenWeatherService>(context, listen: false).longitude = "";

      isWeatherFetched = true;
    }
    isLoadingScreen = false;
    setState(() {});
    return;
  }
}
