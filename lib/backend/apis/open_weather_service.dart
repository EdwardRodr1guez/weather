import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather/backend/models/climate_forecasting_model.dart';
import 'package:weather/backend/models/climate_now_model.dart';

//openweatheservice is a provider which handle weatherdata

class OpenWeatherService extends ChangeNotifier {
  //Configure dio package to make http request
  final dio = Dio(BaseOptions(
    baseUrl: "https://api.openweathermap.org/data/2.5",
  ));

  //variables used by the provider
  ClimateNowModel? climateNowModel;
  ClimateForecastingModel? climateForecastingModel;
  List? directGeocodingModel;

  String? latitude;
  String? longitude;

  //methods of the provider

  //method for get the climate now
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

  //method for get the climate forecasting in the next days
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

  //method for inversegeocoding (the input is a name of the city and the output its coordinates)
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
