import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/provider/favorites_provider.dart';
import 'package:weather/screens/favorites_screen.dart';
import 'package:weather/screens/forecasting_screen.dart';
import 'package:weather/widgets/custom_bottom_navigation.dart';
import 'package:weather/widgets/custom_floatingactionbutton.dart';

class MainWeatherScreen extends StatefulWidget {
  const MainWeatherScreen({
    super.key,
  });

  @override
  State<MainWeatherScreen> createState() => _MainWeatherScreenState();
}

class _MainWeatherScreenState extends State<MainWeatherScreen> {
  /*
    mainwheatherscreen is the core of the application. It's a pageview which show the two sections, weather/forecasting and favorites.
    it consist of, the pageview, a custombottomnavigation and custom floating action buttons.

    *pageview: contains forecasting screen and favorites screen
    *custtombottomnavigation: this allow the user navigate between the previous mentioned screens.
    *custombotton

  */
  PageController pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      delay: const Duration(milliseconds: 100),
      child: Scaffold(
          body: PageView(
            onPageChanged: (value) async {
              currentIndex = value;
              setState(() {});
              if (value == 1) {
                //if the page is favoritesscreen the list of favoritescities is reloaded
                await Provider.of<FavoritesProvider>(context, listen: false)
                    .obtenerListaDesdeSharedPreferences();
              }
              log(currentIndex.toString());
            },
            controller: pageController,
            children: [
              const ForecastingScreen(),
              FavoriteScreen(pageController: pageController)
            ],
          ),
          bottomNavigationBar: CustomBottomNavigation(
              pageController: pageController, currentIndex: currentIndex),
          floatingActionButton:
              CustomFloatingActionButtons(currentIndex: currentIndex)),
    );
  }
}
