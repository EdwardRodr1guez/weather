import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather/backend/models/climate_forecasting_model.dart';
import 'package:weather/backend/models/climate_now_model.dart';

class OpenWeatherService extends ChangeNotifier {
  final dio = Dio(BaseOptions(
    baseUrl: "https://api.openweathermap.org/data/2.5",
  ));

  ClimateNowModel? climateNowModel;
  ClimateForecastingModel? climateForecastingModel;
  List? directGeocodingModel;

  String? latitude;
  String? longitude;

  Future getClimateNow({String? lat, String? lon}) async {
    final response = await dio.get("/weather", queryParameters: {
      "lat": lat ?? "7.907070360220543",
      "lon": lon ?? "-72.5206356164999",
      "appid": "0f7b7f691afb9b79b4e28affd5fc2a9c",
      "lang": "sp",
      "units": "metric"
    });

    climateNowModel = ClimateNowModel.fromMap(response.data);
    latitude = lat ?? "7.907070360220543";
    longitude = lon ?? "-72.5206356164999";

    notifyListeners();
    return climateNowModel;
  }

  Future getClimateForecast({String? lat, String? lon}) async {
    final response = await dio.get("/forecast", queryParameters: {
      "lat": lat ?? "7.907070360220543",
      "lon": lon ?? "-72.5206356164999",
      "appid": "0f7b7f691afb9b79b4e28affd5fc2a9c",
      "lang": "sp",
      "units": "metric"
    });

    climateForecastingModel = ClimateForecastingModel.fromMap(response.data);
    notifyListeners();
    return climateForecastingModel;
  }

  Future getInverseGeocoding({required String query}) async {
    final dioGeo = Dio(BaseOptions(
      baseUrl: "http://api.openweathermap.org/geo/1.0",
    ));
    final response = await dioGeo.get("/direct", queryParameters: {
      "q": query,
      "limit": "5",
      "appid": "0f7b7f691afb9b79b4e28affd5fc2a9c",
    });

    directGeocodingModel = response.data;
    notifyListeners();
    return directGeocodingModel;
  }
}
