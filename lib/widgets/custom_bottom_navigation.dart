import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatefulWidget {
  final PageController pageController;
  const CustomBottomNavigation({
    super.key,
    required this.pageController,
  });

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.green[50],
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(color: Colors.black87),
        useLegacyColorScheme: false,
        showSelectedLabels: true,
        currentIndex: currentIndex,
        onTap: (value) {
          widget.pageController.jumpToPage(value);
          currentIndex = value;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.sunny,
                  color: currentIndex == 0
                      ? Colors.yellow.shade600
                      : Colors.black38),
              label: "Pronóstico"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border_rounded,
                color: currentIndex == 1 ? Colors.red.shade700 : Colors.black38,
              ),
              label: "Mis ciudades")
        ]);
  }
}
