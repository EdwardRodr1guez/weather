import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/backend/apis/open_weather_service.dart';
import 'package:weather/provider/favorites_provider.dart';
import 'package:weather/widgets/show_custom_dialog.dart';

class CustomFloatingActionButtons extends StatefulWidget {
  const CustomFloatingActionButtons({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  State<CustomFloatingActionButtons> createState() =>
      _CustomFloatingActionButtonsState();
}

class _CustomFloatingActionButtonsState
    extends State<CustomFloatingActionButtons> {
  bool fetchingWeather = false;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodySmall;
    final size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (widget.currentIndex == 0)
          FloatingActionButton.extended(
              heroTag: 1,
              onPressed: () async {
                List contador = List.generate(
                    Provider.of<OpenWeatherService>(context, listen: false)
                            .directGeocodingModel
                            ?.length ??
                        0,
                    (index) => false);
                showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                        builder: (context, StateSetter setStatee) {
                      return AlertDialog(
                        contentPadding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 10),
                        scrollable: true,
                        content: SizedBox(
                          width: size.width * 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: size.height * 0.05,
                              ),
                              Text(
                                "Menú de búsqueda",
                                style: titleStyle,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: size.width * 0.6,
                                child: TextField(
                                  onChanged: (value) async {
                                    if ((value != null) & (value != "")) {
                                      final response =
                                          await Provider.of<OpenWeatherService>(
                                                  context,
                                                  listen: false)
                                              .getInverseGeocoding(
                                                  query: value);
                                      if (response != null) {}
                                      contador = List.generate(
                                          Provider.of<OpenWeatherService>(
                                                      context,
                                                      listen: false)
                                                  .directGeocodingModel
                                                  ?.length ??
                                              0,
                                          (index) => false);
                                    }
                                  },
                                  decoration: InputDecoration(
                                      suffixIcon: Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: const IconButton(
                                            onPressed: null,
                                            icon: Icon(Icons.search)),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      hintText: "Ingresa una ciudad"),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              if (Provider.of<OpenWeatherService>(context,
                                          listen: true)
                                      .directGeocodingModel !=
                                  null)
                                Container(
                                  width: size.width * 0.8,
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Resultados",
                                          style: captionStyle,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: size.height * 0.7,
                                        child: ListView.builder(
                                            itemCount:
                                                Provider.of<OpenWeatherService>(
                                                            context,
                                                            listen: true)
                                                        .directGeocodingModel
                                                        ?.length ??
                                                    0,
                                            itemBuilder: (context, index) {
                                              final filter = Provider.of<
                                                          OpenWeatherService>(
                                                      context,
                                                      listen: true)
                                                  .directGeocodingModel;

                                              return ListTile(
                                                trailing: IconButton(
                                                  onPressed: () async {
                                                    /*contador[index] =
                                                        !contador[index];*/
                                                    contador[index] = true;
                                                    FocusScope.of(context)
                                                        .unfocus();

                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .clearSnackBars();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(const SnackBar(
                                                            duration: Duration(
                                                                milliseconds:
                                                                    3000),
                                                            content: Text(
                                                                "Añadido a favoritos, para deshacer cambios dirigirse a 'Mis ciudades' ")));
                                                    setStatee(() {});

                                                    await Provider.of<
                                                                FavoritesProvider>(
                                                            context,
                                                            listen: false)
                                                        .agregarListaEnSharedPreferences(
                                                            filter![index]
                                                                ["name"],
                                                            [
                                                              filter[index]
                                                                  ["lat"],
                                                              filter[index]
                                                                  ["lon"]
                                                            ].toString());
                                                    if (mounted) {
                                                      await Provider.of<
                                                                  FavoritesProvider>(
                                                              context,
                                                              listen: false)
                                                          .obtenerListaDesdeSharedPreferences();
                                                    }
                                                  },
                                                  icon: contador[index] == true
                                                      ? const Icon(
                                                          Icons.favorite,
                                                          color: Colors.red)
                                                      : const Icon(
                                                          Icons.favorite,
                                                          color: Colors.grey),
                                                ),
                                                onTap: () async {
                                                  String lat = filter[index]
                                                          ["lat"]
                                                      .toString();
                                                  String lon = filter[index]
                                                          ["lon"]
                                                      .toString();
                                                  await Provider.of<
                                                              OpenWeatherService>(
                                                          context,
                                                          listen: false)
                                                      .getClimateNow(
                                                          lat: lat, lon: lon);
                                                  await Provider.of<
                                                              OpenWeatherService>(
                                                          context,
                                                          listen: false)
                                                      .getClimateForecast(
                                                          lat: lat, lon: lon);
                                                  if (mounted) {
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                title: RichText(
                                                  text: TextSpan(
                                                    text: 'Ciudad: ',
                                                    style: captionStyle!
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text: filter![index]
                                                                ["name"]
                                                            .toString(),
                                                        style: captionStyle,
                                                      ),
                                                      const TextSpan(
                                                          text: ',    Pais:'),
                                                      TextSpan(
                                                        text: filter[index]
                                                                ["country"]
                                                            .toString(),
                                                        style: captionStyle,
                                                      ),
                                                      const TextSpan(
                                                          text:
                                                              ',    lat/long:'),
                                                      TextSpan(
                                                        text:
                                                            " ${filter[index]["lat"].toString()}/${filter[index]["lon"].toString()}",
                                                        style: captionStyle,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      )
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),
                      );
                    });
                  },
                ).then((value) {
                  Provider.of<OpenWeatherService>(context, listen: false)
                      .directGeocodingModel = [];
                });
              },
              label: const Text("Buscar Ciudad")),
        const SizedBox(
          height: 15,
        ),
        if (widget.currentIndex == 0)
          Opacity(
            opacity: Provider.of<OpenWeatherService>(context, listen: true)
                        .latitude ==
                    ""
                ? 0.5
                : 1,
            child: FloatingActionButton.extended(
                heroTag: 2,
                onPressed: () async {
                  final openWeatherService =
                      Provider.of<OpenWeatherService>(context, listen: false);
                  if (openWeatherService.latitude == "") {
                    ShowCustomDialog.ShowCustomNotLocationFoundDialog(context);
                  } else {
                    fetchingWeather = true;

                    await openWeatherService.getClimateNow(
                        lat: openWeatherService.latitude,
                        lon: openWeatherService.longitude);
                    setState(() {});
                    await openWeatherService.getClimateForecast(
                        lon: openWeatherService.longitude,
                        lat: openWeatherService.latitude);
                    fetchingWeather = false;
                    setState(() {});
                  }
                },
                label: fetchingWeather
                    ? const CircularProgressIndicator(
                        strokeWidth: 2,
                      )
                    : const Text("Actualizar clima")),
          ),
      ],
    );
  }
}
