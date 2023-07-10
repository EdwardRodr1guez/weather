import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather/backend/apis/open_weather_service.dart';

class ShowCustomDialog {
  static ShowCustomLocationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¡Ubicación actual no encontrada! 🌩️'),
          content: const Text(
            'Estamos comprometidos con la privacidad de nuestros usuarios,\nsolo queremos conocerla para mostrarte predicciones del clima ☁️⛅🌥️🌦️🌧️ \nPero si no te parece, no te preocupes! puedes probar con la ubicación de tu elección!',
            textAlign: TextAlign.justify,
          ),
          actions: <Widget>[
            FilledButton(
              child: const Text('Quizás luego '),
              onPressed: () {
                // Código a ejecutar al presionar el botón Cancelar
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
            ),
            FilledButton(
              child: const Text('Compartir mi ubicación'),
              onPressed: () async {
                // Código a ejecutar al presionar el botón Aceptar
                LocationPermission locationTemp =
                    await Geolocator.requestPermission();
                if ((locationTemp == LocationPermission.always) ||
                    (locationTemp == LocationPermission.whileInUse)) {
                  final Position position =
                      await Geolocator.getCurrentPosition();
                  String lat = position.latitude.toString();
                  String lon = position.longitude.toString();

                  await Provider.of<OpenWeatherService>(context, listen: false)
                      .getClimateNow(lat: lat, lon: lon);
                  await Provider.of<OpenWeatherService>(context, listen: false)
                      .getClimateForecast(lat: lat, lon: lon);
                }
                if (Platform.isWindows) {
                  await Geolocator.openLocationSettings();
                }

                //poner condición para cuando solo sea windows
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
            ),
          ],
        );
      },
    );
  }

  static ShowCustomNotLocationFoundDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¡Ubicación actual no encontrada! 🌩️'),
          content: const Text(
            'Activa tu ubicación o busca una nueva ciudad ',
            textAlign: TextAlign.justify,
          ),
          actions: <Widget>[
            FilledButton(
              child: const Text('Entendido!'),
              onPressed: () {
                // Código a ejecutar al presionar el botón Cancelar
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
            ),
          ],
        );
      },
    );
  }
}
