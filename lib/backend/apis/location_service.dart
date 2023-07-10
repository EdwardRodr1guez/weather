import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/widgets/show_custom_dialog.dart';

class LocationService {
  static Future<bool> handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ShowCustomDialog.ShowCustomLocationDialog(context);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ShowCustomDialog.ShowCustomLocationDialog(context);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ShowCustomDialog.ShowCustomLocationDialog(context);
      return false;
    }
    return true;
  }
}
