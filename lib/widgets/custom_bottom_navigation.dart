import 'dart:developer';

import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatefulWidget {
  final int currentIndex;
  final PageController pageController;
  const CustomBottomNavigation({
    super.key,
    required this.pageController,
    required this.currentIndex,
  });

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

/*
custom bottom navigation. show two icons and allow the user to change between
forecasting page and favorites section
*/
class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    log(widget.currentIndex.toString());
    return BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.green[50],
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(color: Colors.black87),
        useLegacyColorScheme: false,
        showSelectedLabels: true,
        currentIndex: widget.currentIndex, //currentIndex,
        onTap: (value) {
          widget.pageController.jumpToPage(value);
          currentIndex = value;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.sunny,
                  color: widget.currentIndex == 0
                      ? Colors.yellow.shade600
                      : Colors.black38),
              label: "Pronóstico"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border_rounded,
                color: widget.currentIndex == 1
                    ? Colors.red.shade700
                    : Colors.black38,
              ),
              label: "Mis ciudades")
        ]);
  }
}
