import 'package:flutter_test/flutter_test.dart';

import 'package:weather/provider/favorites_provider.dart';

void main() {
  group('Grupo de pruebas provider favoritos', () {
    test('Prueba 1: mis favoritos', () {
      final favoriteProvider = FavoritesProvider();
      expect(favoriteProvider.myFavorites, []);
    });

    test('Prueba 2: localización de mis favoritos', () {
      final favoriteProvider = FavoritesProvider();
      expect(favoriteProvider.myFavoritesLocation, []);
    });

    test('Prueba 3: likes', () {
      final favoriteProvider = FavoritesProvider();
      expect(favoriteProvider.likes, []);
    });

    test('Prueba 4: index', () {
      final favoriteProvider = FavoritesProvider();
      expect(favoriteProvider.index, -1);
    });
  });
}
