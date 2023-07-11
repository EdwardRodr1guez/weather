import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/provider/favorites_provider.dart';

main() {
  group('agregarListaEnSharedPreferences', () {
    testWidgets(
        "add favorite city: test is passed if user add a NOT REPEATED KEY",
        (WidgetTester tester) async {
      WidgetsFlutterBinding.ensureInitialized();

      const expectedStatus = true;
      final favoriteProvider = FavoritesProvider();
      final actualStatus = await favoriteProvider
          .agregarListaEnSharedPreferences("ciudad", "madrid");

      expect(expectedStatus, actualStatus);
    });

    testWidgets("delete a favorite city: test is passed if the key exist",
        (WidgetTester tester) async {
      WidgetsFlutterBinding.ensureInitialized();

      const expectedStatus = false;
      final favoriteProvider = FavoritesProvider();
      final actualStatus = await favoriteProvider.eliminarFavorito("ciudadk");

      expect(expectedStatus, actualStatus);
    });
  });
}
