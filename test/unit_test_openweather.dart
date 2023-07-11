import 'package:flutter_test/flutter_test.dart';
import 'package:weather/backend/apis/open_weather_service.dart';

void main() {
  group('Grupo de pruebas openweather', () {
    test('Prueba 1: mis favoritos', () {
      final openWeatherProvider = OpenWeatherService();
      expect(openWeatherProvider.climateForecastingModel, null);
    });
  });
}
