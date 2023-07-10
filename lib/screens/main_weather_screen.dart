import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
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
  PageController pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      delay: const Duration(milliseconds: 100),
      child: Scaffold(
          body: PageView(
            onPageChanged: (value) {
              currentIndex = value;
              setState(() {});
            },
            controller: pageController,
            children: [
              const ForecastingScreen(),
              FavoriteScreen(pageController: pageController)
            ],
          ),
          bottomNavigationBar:
              CustomBottomNavigation(pageController: pageController),
          floatingActionButton:
              CustomFloatingActionButtons(currentIndex: currentIndex)),
    );
  }
}
