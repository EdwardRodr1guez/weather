import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

//favorites provider to handle favorite cities preferences of the user

class FavoritesProvider extends ChangeNotifier {
  //provider variables

  List myFavorites = [];
  Set myFavoritesLocation = {};
  List likes = [];
  int index = -1;

  //Methods:

  //storage in memory a favorite city
  Future<bool> agregarListaEnSharedPreferences(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool repeated = prefs.containsKey(key);
    if (repeated) {
      return false;
    }

    prefs.setString(key, value);
    notifyListeners();
    return true;
  }

  //read in storage the favorite cities
  Future<Set> obtenerListaDesdeSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Obtiene la cadena de SharedPreferences
    List lista = prefs.getKeys().toList() ?? [];

    myFavorites = lista;
    for (var element in myFavorites) {
      myFavoritesLocation.add(prefs.getString(element));
    }

    notifyListeners();
    return myFavoritesLocation;
  }

  //delete favorite city
  Future<bool> eliminarFavorito(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool repeated = prefs.containsKey(key);
    if (repeated) {
      await prefs.remove(key);
      notifyListeners();
      return true;
    }
    return false;
  }
}
