// To parse this JSON data, do
//
//     final directGeocodingModel = directGeocodingModelFromMap(jsonString);

import 'dart:convert';

List<DirectGeocodingModel> directGeocodingModelFromMap(String str) =>
    List<DirectGeocodingModel>.from(
        json.decode(str).map((x) => DirectGeocodingModel.fromMap(x)));

String directGeocodingModelToMap(List<DirectGeocodingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class DirectGeocodingModel {
  String? name;
  LocalNames? localNames;
  double? lat;
  double? lon;
  String? country;
  String? state;

  DirectGeocodingModel({
    this.name,
    this.localNames,
    this.lat,
    this.lon,
    this.country,
    this.state,
  });

  factory DirectGeocodingModel.fromMap(Map<String, dynamic> json) =>
      DirectGeocodingModel(
        name: json["name"],
        localNames: json["local_names"] == null
            ? null
            : LocalNames.fromMap(json["local_names"]),
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        country: json["country"],
        state: json["state"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "local_names": localNames?.toMap(),
        "lat": lat,
        "lon": lon,
        "country": country,
        "state": state,
      };
}

class LocalNames {
  String? uk;
  String? ar;
  String? en;
  String? mk;
  String? oc;
  String? ru;
  String? es;
  String? fa;
  String? pt;
  String? ur;

  LocalNames({
    this.uk,
    this.ar,
    this.en,
    this.mk,
    this.oc,
    this.ru,
    this.es,
    this.fa,
    this.pt,
    this.ur,
  });

  factory LocalNames.fromMap(Map<String, dynamic> json) => LocalNames(
        uk: json["uk"],
        ar: json["ar"],
        en: json["en"],
        mk: json["mk"],
        oc: json["oc"],
        ru: json["ru"],
        es: json["es"],
        fa: json["fa"],
        pt: json["pt"],
        ur: json["ur"],
      );

  Map<String, dynamic> toMap() => {
        "uk": uk,
        "ar": ar,
        "en": en,
        "mk": mk,
        "oc": oc,
        "ru": ru,
        "es": es,
        "fa": fa,
        "pt": pt,
        "ur": ur,
      };
}
