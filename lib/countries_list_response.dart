// To parse this JSON data, do
//
//     final googlePlaceDetailsFromPlaceIdResponse = googlePlaceDetailsFromPlaceIdResponseFromJson(jsonString);

import 'dart:convert';

CountryDataResponse countryDataResponseFromJson(String str) => CountryDataResponse.fromJson(json.decode(str));

String googlePlaceDetailsFromPlaceIdResponseToJson(CountryDataResponse data) => json.encode(data.toJson());

class CountryDataResponse {
  CountryDataResponse({
    this.status,
    this.statusCode,
    this.version,
    this.access,
    this.data,
  });

  String ? status;
  int ? statusCode;
  String ? version;
  String ? access;
  Map<String, Datum> ? data;

  factory CountryDataResponse.fromJson(Map<String, dynamic> json) => CountryDataResponse(
    status: json["status"] == null ? null : json["status"],
    statusCode: json["status-code"] == null ? null : json["status-code"],
    version: json["version"] == null ? null : json["version"],
    access: json["access"] == null ? null : json["access"],
    data: json["data"] == null ? null : Map.from(json["data"]).map((k, v) => MapEntry<String, Datum>(k, Datum.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "status-code": statusCode == null ? null : statusCode,
    "version": version == null ? null : version,
    "access": access == null ? null : access,
    "data": data == null ? null : Map.from(data!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class Datum {
  Datum({
    this.country,
    this.region,
  });

  String ? country;
  Region ? region;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    country: json["country"] == null ? null : json["country"],
    region: json["region"] == null ? null : regionValues.map![json["region"]],
  );

  Map<String, dynamic> toJson() => {
    "country": country == null ? null : country,
    "region": region == null ? null : regionValues.reverse![region],
  };
}

enum  Region { ASIA, AFRICA, ANTARCTIC, CENTRAL_AMERICA }

final regionValues = EnumValues({
  "Africa": Region.AFRICA,
  "Antarctic": Region.ANTARCTIC,
  "Asia": Region.ASIA,
  "Central America": Region.CENTRAL_AMERICA
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
