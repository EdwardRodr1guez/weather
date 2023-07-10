import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/backend/apis/open_weather_service.dart';
import 'package:weather/backend/models/climate_forecasting_model.dart';
import 'package:weather/backend/models/climate_now_model.dart';

class ForecastingScreen extends StatelessWidget {
  const ForecastingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ClimateNowModel? climateNowModel =
        Provider.of<OpenWeatherService>(context).climateNowModel;

    ClimateForecastingModel? climateForecastingModel =
        Provider.of<OpenWeatherService>(context).climateForecastingModel;
    final height = MediaQuery.of(context).size.height;
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodySmall;
    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: 0.5,
          child: Image(
            height: height,
            width: double.infinity,
            image: const AssetImage("assets/c.png"),
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox.expand(
          child: DecoratedBox(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      stops: [0, 0.33, 0.8],
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(0, 0, 0, 0.9),
                        Colors.transparent,
                        Color.fromRGBO(0, 0, 0, 0.35)
                      ]))),
        ),
        SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: height * 0.15, bottom: 20),
                    child: Provider.of<OpenWeatherService>(context,
                                    listen: true)
                                .latitude !=
                            ""
                        ? Text(
                            "${climateNowModel!.name} (Hoy) " ??
                                "Buscando tu ciudad...",
                            style: titleStyle!
                                .copyWith(color: Colors.black, fontSize: 28),
                          )
                        : Text(
                            "Ubicación no encontrada",
                            style: titleStyle!
                                .copyWith(color: Colors.black, fontSize: 28),
                          )),
                Provider.of<OpenWeatherService>(context, listen: true)
                            .longitude !=
                        ""
                    ? _CustomWeatherCard(
                        height: height,
                        captionStyle: captionStyle,
                        description: climateNowModel!.weather![0].description,
                        icon: climateNowModel.weather![0].icon,
                        maxTemp: climateNowModel.main!.tempMax,
                        minTemp: climateNowModel.main!.tempMin,
                        temp: climateNowModel.main!.temp)
                    : _CustomEmptyWeatherCard(
                        height: height,
                        captionStyle: captionStyle!,
                      ),
                Container(
                    margin: EdgeInsets.only(top: height * 0.15, bottom: 20),
                    child: Text(
                      "Tu pronóstico",
                      style: titleStyle.copyWith(
                          color: Colors.black, fontSize: 20),
                    )),
                Provider.of<OpenWeatherService>(context, listen: true)
                            .latitude !=
                        ""
                    ? SizedBox(
                        height: height * 0.32,
                        width: double.infinity,
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(
                            dragDevices: {
                              PointerDeviceKind.touch,
                              PointerDeviceKind.mouse,
                            },
                          ),
                          child: ListView.builder(
                            itemCount: climateForecastingModel?.list?.length ??
                                [].length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              final forecasting =
                                  climateForecastingModel?.list?[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: _CustomWeatherCard(
                                    showHour: forecasting!.dtTxt.toString(),
                                    height: height,
                                    captionStyle: captionStyle,
                                    description:
                                        forecasting.weather![0].description,
                                    icon: forecasting.weather![0].icon,
                                    maxTemp: forecasting.main!.tempMax,
                                    minTemp: forecasting.main!.tempMin,
                                    temp: forecasting.main!.temp),
                              );
                            },
                          ),
                        ),
                      )
                    : _CustomEmptyWeatherCard(
                        height: height,
                        captionStyle: captionStyle!,
                      )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _CustomWeatherCard extends StatelessWidget {
  final String? showHour;
  final String? icon;
  final double? maxTemp;
  final double? temp;
  final double? minTemp;
  final String? description;

  const _CustomWeatherCard({
    required this.height,
    this.showHour,
    this.icon,
    this.maxTemp,
    this.temp,
    this.minTemp,
    this.description,
    this.captionStyle,
  });

  final double height;
  final TextStyle? captionStyle;

  String convertirFormatoFecha(String fechaString) {
    // Convierte la cadena de fecha en un objeto DateTime
    DateTime fecha = DateTime.parse(fechaString);

    // Formatea la fecha en el formato deseado: "yyyy-mm-dd hh:mm:ss"
    String fechaFormateada = "${fecha.year.toString().padLeft(4, '0')}-"
        "${fecha.month.toString().padLeft(2, '0')}-"
        "${fecha.day.toString().padLeft(2, '0')} "
        "${fecha.hour.toString().padLeft(2, '0')}:"
        "${fecha.minute.toString().padLeft(2, '0')}:"
        "${fecha.second.toString().padLeft(2, '0')}";

    return fechaFormateada;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: height * 0.03,
      ),
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(30)),
      height: 200,
      width: 200,
      child: Column(
        children: [
          if ((icon != null) & (icon != ""))
            Swing(
                animate: true,
                infinite: true,
                duration: const Duration(seconds: 2),
                child: Image.network(
                  "https://openweathermap.org/img/wn/$icon@2x.png",
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return const Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ));
                    }
                    return child;
                  },
                  width: 100,
                  height: 100,
                  fit: BoxFit.scaleDown,
                )),
          if (temp != null) Text("${temp!}°C"),
          Text(
            description ?? "Error al cargar datos",
            style: captionStyle!.copyWith(fontStyle: FontStyle.italic),
          ),
          if (showHour != null) Text(convertirFormatoFecha(showHour!)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Temp. Min",
                      style: captionStyle!
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                    Text("${minTemp ?? 'xxx'}°C"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Temp. Max",
                        style: captionStyle!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        )),
                    Text("${maxTemp ?? 'xxx'}°C"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomEmptyWeatherCard extends StatelessWidget {
  const _CustomEmptyWeatherCard({
    required this.height,
    required this.captionStyle,
  });

  final double height;
  //final ClimateNowModel climateNowModel;
  final TextStyle captionStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: height * 0.03,
      ),
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(30)),
      height: 200,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Selecciona una ciudad",
            style: captionStyle.copyWith(fontStyle: FontStyle.italic),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Temp. Min",
                      style: captionStyle.copyWith(
                          fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                    const Text("xxx°C"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Temp. Max",
                        style: captionStyle.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        )),
                    const Text("xxx°C"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
