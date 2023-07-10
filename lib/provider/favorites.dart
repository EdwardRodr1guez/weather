import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  List myFavorites = [];
  List myFavoritesLocation = [];
  List likes = [];
  int index = -1;

  Future<void> agregarListaEnSharedPreferences(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    notifyListeners();
  }

  Future<List> obtenerListaDesdeSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Obtiene la cadena de SharedPreferences
    List lista = prefs.getKeys().toList() ?? [];

    myFavorites = lista;
    for (var element in myFavorites) {
      myFavoritesLocation.add(prefs.getString(element));
    }

    notifyListeners();
    return lista;
  }
}
