import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/backend/apis/open_weather_service.dart';
import 'package:weather/provider/favorites.dart';

class FavoriteScreen extends StatefulWidget {
  final PageController pageController;
  const FavoriteScreen({
    super.key,
    required this.pageController,
  });

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    getFavorites();
  }

  Future<void> getFavorites() async {
    await Provider.of<FavoritesProvider>(context, listen: false)
        .obtenerListaDesdeSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodySmall;

    final favoritesProvider =
        Provider.of<FavoritesProvider>(context, listen: true);
    final size = MediaQuery.of(context).size;
    return favoritesProvider.myFavorites.isNotEmpty
        ? SizedBox(
            height: height * 0.3,
            width: 200,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: ListView.builder(
                itemCount: favoritesProvider.myFavorites.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {
                      List a = favoritesProvider.myFavoritesLocation[index]
                          .toString()
                          .substring(
                              1,
                              favoritesProvider
                                      .myFavoritesLocation[index].length -
                                  1)
                          .split(",");

                      String lat = a[0].toString().trim();
                      String lon = a[1].toString().trim();

                      await Provider.of<OpenWeatherService>(context,
                              listen: false)
                          .getClimateNow(lat: lat, lon: lon);
                      await Provider.of<OpenWeatherService>(context,
                              listen: false)
                          .getClimateForecast(lat: lat, lon: lon);
                      widget.pageController.jumpToPage(0);
                      //Hacer la navegación
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 25),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Colors.transparent,
                            Colors.black87,
                            Colors.transparent,
                          ]),
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              opacity: 0.5,
                              image: AssetImage("assets/c.png"))),
                      height: 200,
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                favoritesProvider.myFavorites[index].toString(),
                                style: titleStyle,
                              ),
                              Text(
                                favoritesProvider.myFavoritesLocation[index]
                                    .toString(),
                                style: captionStyle,
                              ),
                            ]),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        : const Center(
            child: Text("No hay ciudades en tu lista de favoritas"),
          );
  }

  List<int> extractValues({required String input}) {
    String numbersString = input.substring(1, input.length - 1);
    List<String> numbersList = numbersString.split(",");

    if (numbersList.length == 2) {
      int? a = int.tryParse(numbersList[0].trim());
      int? b = int.tryParse(numbersList[1].trim());

      if (a != null && b != null) {
        return [a, b];
      }
    }

    // Si el formato del string no es válido o no se pueden convertir a números
    return [];
  }
}
