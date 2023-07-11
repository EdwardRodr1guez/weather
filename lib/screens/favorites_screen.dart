import 'dart:developer';
import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/backend/apis/open_weather_service.dart';
import 'package:weather/provider/favorites_provider.dart';

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
  bool isFetching = false;
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
              child: Stack(children: [
                Opacity(
                  opacity: isFetching ? 0.4 : 1,
                  child: ListView.builder(
                    itemCount: favoritesProvider.myFavorites.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () async {
                          isFetching = true;
                          setState(() {});
                          print(await Provider.of<FavoritesProvider>(context,
                                  listen: false)
                              .obtenerListaDesdeSharedPreferences());

                          final favoritesLocation =
                              Provider.of<FavoritesProvider>(context,
                                      listen: false)
                                  .myFavoritesLocation
                                  .toList()[index];

                          /*print(favoritesLocation
                                .split(",")
                                .toString()
                                .substring(2, favoritesLocation.length + 1));*/

                          List latitudeLongitude = favoritesLocation
                              .split(",")
                              .toString()
                              .substring(2, favoritesLocation.length + 1)
                              .trim()
                              .split(",");

                          String lat = latitudeLongitude[0].trim();
                          String lon = latitudeLongitude[1].trim();

                          log(lat);
                          log(lon);

                          await Provider.of<OpenWeatherService>(context,
                                  listen: false)
                              .getClimateNow(lat: lat, lon: lon);
                          await Provider.of<OpenWeatherService>(context,
                                  listen: false)
                              .getClimateForecast(lat: lat, lon: lon);
                          isFetching = false;
                          setState(() {});
                          widget.pageController.jumpToPage(0);
                        },
                        child: FadeIn(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      favoritesProvider.myFavorites[index]
                                          .toString(),
                                      style: titleStyle,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                              onPressed: () async {
                                                await Provider.of<
                                                            FavoritesProvider>(
                                                        context,
                                                        listen: false)
                                                    .eliminarFavorito(
                                                        favoritesProvider
                                                            .myFavorites[index]
                                                            .toString());
                                                await Provider.of<
                                                            FavoritesProvider>(
                                                        context,
                                                        listen: false)
                                                    .obtenerListaDesdeSharedPreferences();
                                              },
                                              icon: const Icon(
                                                  Icons.delete_forever)),
                                          Text(
                                            favoritesProvider
                                                .myFavoritesLocation
                                                .toList()[index]
                                                .toString(),
                                            style: captionStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (isFetching)
                  const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                //
              ]),
            ),
          )
        : const Center(
            child: Text("No hay ciudades en tu lista de favoritas"),
          );
  }

  List getPairString(Set<dynamic> inputSet, int index) {
    List<dynamic> inputList = inputSet.toList();

    if (index < 0 || index >= inputList.length) {
      return []; // Índice fuera de rango, retorna una cadena vacía o puedes manejar el error de otra manera
    }

    List<dynamic> pair = inputList[index];

    return [pair[0].toString(), pair[1].toString()];
  }
}
