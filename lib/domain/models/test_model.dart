// To parse this JSON data, do
//
//     final welcomeA = welcomeAFromJson(jsonString);

import 'dart:convert';

import 'package:take_me_there_app/domain/models/place_model.dart';

WelcomeA welcomeAFromJson(String str) => WelcomeA.fromJson(json.decode(str));

String welcomeAToJson(WelcomeA data) => json.encode(data.toJson());

class WelcomeA {
  String type;
  String id;
  int score;
  int dist;
  String info;
  String entityType;
  Poi poi;
  List<RelatedPois> relatedPois;
  Address address;
  PositionLatLng position;
  List<Mapcode> mapcodes;
  Viewport viewport;
  List<EntryPoint> entryPoints;
  AddressRanges addressRanges;
  ChargingPark chargingPark;
  DataSources dataSources;

  WelcomeA({
    required this.type,
    required this.id,
    required this.score,
    required this.dist,
    required this.info,
    required this.entityType,
    required this.poi,
    required this.relatedPois,
    required this.address,
    required this.position,
    required this.mapcodes,
    required this.viewport,
    required this.entryPoints,
    required this.addressRanges,
    required this.chargingPark,
    required this.dataSources,
  });

  factory WelcomeA.fromJson(Map<String, dynamic> json) => WelcomeA(
        type: json["type"],
        id: json["id"],
        score: json["score"],
        dist: json["dist"],
        info: json["info"],
        entityType: json["entityType"],
        poi: Poi.fromJson(json["poi"]),
        relatedPois: List<RelatedPois>.from(
            json["relatedPois"].map((x) => RelatedPois.fromJson(x))),
        address: Address.fromJson(json["address"]),
        position: PositionLatLng.fromJson(json["position"]),
        mapcodes: List<Mapcode>.from(
            json["mapcodes"].map((x) => Mapcode.fromJson(x))),
        viewport: Viewport.fromJson(json["viewport"]),
        entryPoints: List<EntryPoint>.from(
            json["entryPoints"].map((x) => EntryPoint.fromJson(x))),
        addressRanges: AddressRanges.fromJson(json["addressRanges"]),
        chargingPark: ChargingPark.fromJson(json["chargingPark"]),
        dataSources: DataSources.fromJson(json["dataSources"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "score": score,
        "dist": dist,
        "info": info,
        "entityType": entityType,
        "poi": poi.toJson(),
        "relatedPois": List<dynamic>.from(relatedPois.map((x) => x.toJson())),
        "address": address.toJson(),
        "position": position.toJson(),
        "mapcodes": List<dynamic>.from(mapcodes.map((x) => x.toJson())),
        "viewport": viewport.toJson(),
        "entryPoints": List<dynamic>.from(entryPoints.map((x) => x.toJson())),
        "addressRanges": addressRanges.toJson(),
        "chargingPark": chargingPark.toJson(),
        "dataSources": dataSources.toJson(),
      };
}

class Address {
  String streetNumber;
  String streetName;
  String municipalitySubdivision;
  String municipality;
  String countrySecondarySubdivision;
  String countryTertiarySubdivision;
  String countrySubdivision;
  String postalCode;
  String extendedPostalCode;
  String countryCode;
  String country;
  String countryCodeIso3;
  String freeformAddress;
  String countrySubdivisionName;
  String localName;

  Address({
    required this.streetNumber,
    required this.streetName,
    required this.municipalitySubdivision,
    required this.municipality,
    required this.countrySecondarySubdivision,
    required this.countryTertiarySubdivision,
    required this.countrySubdivision,
    required this.postalCode,
    required this.extendedPostalCode,
    required this.countryCode,
    required this.country,
    required this.countryCodeIso3,
    required this.freeformAddress,
    required this.countrySubdivisionName,
    required this.localName,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        streetNumber: json["streetNumber"],
        streetName: json["streetName"],
        municipalitySubdivision: json["municipalitySubdivision"],
        municipality: json["municipality"],
        countrySecondarySubdivision: json["countrySecondarySubdivision"],
        countryTertiarySubdivision: json["countryTertiarySubdivision"],
        countrySubdivision: json["countrySubdivision"],
        postalCode: json["postalCode"],
        extendedPostalCode: json["extendedPostalCode"],
        countryCode: json["countryCode"],
        country: json["country"],
        countryCodeIso3: json["countryCodeISO3"],
        freeformAddress: json["freeformAddress"],
        countrySubdivisionName: json["countrySubdivisionName"],
        localName: json["localName"],
      );

  Map<String, dynamic> toJson() => {
        "streetNumber": streetNumber,
        "streetName": streetName,
        "municipalitySubdivision": municipalitySubdivision,
        "municipality": municipality,
        "countrySecondarySubdivision": countrySecondarySubdivision,
        "countryTertiarySubdivision": countryTertiarySubdivision,
        "countrySubdivision": countrySubdivision,
        "postalCode": postalCode,
        "extendedPostalCode": extendedPostalCode,
        "countryCode": countryCode,
        "country": country,
        "countryCodeISO3": countryCodeIso3,
        "freeformAddress": freeformAddress,
        "countrySubdivisionName": countrySubdivisionName,
        "localName": localName,
      };
}

class AddressRanges {
  String rangeLeft;
  String rangeRight;
  PositionLatLng from;
  PositionLatLng to;

  AddressRanges({
    required this.rangeLeft,
    required this.rangeRight,
    required this.from,
    required this.to,
  });

  factory AddressRanges.fromJson(Map<String, dynamic> json) => AddressRanges(
        rangeLeft: json["rangeLeft"],
        rangeRight: json["rangeRight"],
        from: PositionLatLng.fromJson(json["from"]),
        to: PositionLatLng.fromJson(json["to"]),
      );

  Map<String, dynamic> toJson() => {
        "rangeLeft": rangeLeft,
        "rangeRight": rangeRight,
        "from": from.toJson(),
        "to": to.toJson(),
      };
}

class PositionLatLng {
  double lat;
  double lon;

  PositionLatLng({
    required this.lat,
    required this.lon,
  });

  factory PositionLatLng.fromJson(Map<String, dynamic> json) => PositionLatLng(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
      };
}

class ChargingPark {
  List<Connector> connectors;

  ChargingPark({
    required this.connectors,
  });

  factory ChargingPark.fromJson(Map<String, dynamic> json) => ChargingPark(
        connectors: List<Connector>.from(
            json["connectors"].map((x) => Connector.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "connectors": List<dynamic>.from(connectors.map((x) => x.toJson())),
      };
}

class Connector {
  String connectorType;
  double ratedPowerKw;
  int currentA;
  String currentType;
  int voltageV;

  Connector({
    required this.connectorType,
    required this.ratedPowerKw,
    required this.currentA,
    required this.currentType,
    required this.voltageV,
  });

  factory Connector.fromJson(Map<String, dynamic> json) => Connector(
        connectorType: json["connectorType"],
        ratedPowerKw: json["ratedPowerKW"]?.toDouble(),
        currentA: json["currentA"],
        currentType: json["currentType"],
        voltageV: json["voltageV"],
      );

  Map<String, dynamic> toJson() => {
        "connectorType": connectorType,
        "ratedPowerKW": ratedPowerKw,
        "currentA": currentA,
        "currentType": currentType,
        "voltageV": voltageV,
      };
}

class DataSources {
  ChargingAvailability chargingAvailability;
  ChargingAvailability parkingAvailability;
  ChargingAvailability fuelPrice;
  ChargingAvailability geometry;

  DataSources({
    required this.chargingAvailability,
    required this.parkingAvailability,
    required this.fuelPrice,
    required this.geometry,
  });

  factory DataSources.fromJson(Map<String, dynamic> json) => DataSources(
        chargingAvailability:
            ChargingAvailability.fromJson(json["chargingAvailability"]),
        parkingAvailability:
            ChargingAvailability.fromJson(json["parkingAvailability"]),
        fuelPrice: ChargingAvailability.fromJson(json["fuelPrice"]),
        geometry: ChargingAvailability.fromJson(json["geometry"]),
      );

  Map<String, dynamic> toJson() => {
        "chargingAvailability": chargingAvailability.toJson(),
        "parkingAvailability": parkingAvailability.toJson(),
        "fuelPrice": fuelPrice.toJson(),
        "geometry": geometry.toJson(),
      };
}

class ChargingAvailability {
  String id;

  ChargingAvailability({
    required this.id,
  });

  factory ChargingAvailability.fromJson(Map<String, dynamic> json) =>
      ChargingAvailability(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class EntryPoint {
  String type;
  PositionLatLng position;
  List<String>? functions;

  EntryPoint({
    required this.type,
    required this.position,
    this.functions,
  });

  factory EntryPoint.fromJson(Map<String, dynamic> json) => EntryPoint(
        type: json["type"],
        position: PositionLatLng.fromJson(json["position"]),
        functions: json["functions"] == null
            ? []
            : List<String>.from(json["functions"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "position": position.toJson(),
        "functions": functions == null
            ? []
            : List<dynamic>.from(functions!.map((x) => x)),
      };
}

class Mapcode {
  String type;
  String fullMapcode;
  String? territory;
  String? code;

  Mapcode({
    required this.type,
    required this.fullMapcode,
    this.territory,
    this.code,
  });

  factory Mapcode.fromJson(Map<String, dynamic> json) => Mapcode(
        type: json["type"],
        fullMapcode: json["fullMapcode"],
        territory: json["territory"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "fullMapcode": fullMapcode,
        "territory": territory,
        "code": code,
      };
}

class Poi {
  String name;
  String phone;
  String url;
  List<Brand> brands;
  List<CategorySet> categorySet;
  List<String> categories;
  OpeningHours openingHours;
  List<Classification> classifications;
  TimeZone timeZone;

  Poi({
    required this.name,
    required this.phone,
    required this.url,
    required this.brands,
    required this.categorySet,
    required this.categories,
    required this.openingHours,
    required this.classifications,
    required this.timeZone,
  });

  factory Poi.fromJson(Map<String, dynamic> json) => Poi(
        name: json["name"],
        phone: json["phone"],
        url: json["url"],
        brands: List<Brand>.from(json["brands"].map((x) => Brand.fromJson(x))),
        categorySet: List<CategorySet>.from(
            json["categorySet"].map((x) => CategorySet.fromJson(x))),
        categories: List<String>.from(json["categories"].map((x) => x)),
        openingHours: OpeningHours.fromJson(json["openingHours"]),
        classifications: List<Classification>.from(
            json["classifications"].map((x) => Classification.fromJson(x))),
        timeZone: TimeZone.fromJson(json["timeZone"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "url": url,
        "brands": List<dynamic>.from(brands.map((x) => x.toJson())),
        "categorySet": List<dynamic>.from(categorySet.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "openingHours": openingHours.toJson(),
        "classifications":
            List<dynamic>.from(classifications.map((x) => x.toJson())),
        "timeZone": timeZone.toJson(),
      };
}

class Brand {
  String name;

  Brand({
    required this.name,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class CategorySet {
  int id;

  CategorySet({
    required this.id,
  });

  factory CategorySet.fromJson(Map<String, dynamic> json) => CategorySet(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class Classification {
  String code;
  List<Name> names;

  Classification({
    required this.code,
    required this.names,
  });

  factory Classification.fromJson(Map<String, dynamic> json) => Classification(
        code: json["code"],
        names: List<Name>.from(json["names"].map((x) => Name.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "names": List<dynamic>.from(names.map((x) => x.toJson())),
      };
}

class Name {
  String nameLocale;
  String name;

  Name({
    required this.nameLocale,
    required this.name,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        nameLocale: json["nameLocale"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "nameLocale": nameLocale,
        "name": name,
      };
}

class OpeningHours {
  String mode;
  List<TimeRange> timeRanges;

  OpeningHours({
    required this.mode,
    required this.timeRanges,
  });

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        mode: json["mode"],
        timeRanges: List<TimeRange>.from(
            json["timeRanges"].map((x) => TimeRange.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mode": mode,
        "timeRanges": List<dynamic>.from(timeRanges.map((x) => x.toJson())),
      };
}

class TimeRange {
  Time startTime;
  Time endTime;

  TimeRange({
    required this.startTime,
    required this.endTime,
  });

  factory TimeRange.fromJson(Map<String, dynamic> json) => TimeRange(
        startTime: Time.fromJson(json["startTime"]),
        endTime: Time.fromJson(json["endTime"]),
      );

  Map<String, dynamic> toJson() => {
        "startTime": startTime.toJson(),
        "endTime": endTime.toJson(),
      };
}

class Time {
  DateTime date;
  int hour;
  int minute;

  Time({
    required this.date,
    required this.hour,
    required this.minute,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        date: DateTime.parse(json["date"]),
        hour: json["hour"],
        minute: json["minute"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "hour": hour,
        "minute": minute,
      };
}

class TimeZone {
  String ianaId;

  TimeZone({
    required this.ianaId,
  });

  factory TimeZone.fromJson(Map<String, dynamic> json) => TimeZone(
        ianaId: json["ianaId"],
      );

  Map<String, dynamic> toJson() => {
        "ianaId": ianaId,
      };
}

class RelatedPois {
  String relationType;
  String id;

  RelatedPois({
    required this.relationType,
    required this.id,
  });

  factory RelatedPois.fromJson(Map<String, dynamic> json) => RelatedPois(
        relationType: json["relationType"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "relationType": relationType,
        "id": id,
      };
}

class Viewport {
  PositionLatLng topLeftPoint;
  PositionLatLng btmRightPoint;

  Viewport({
    required this.topLeftPoint,
    required this.btmRightPoint,
  });

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        topLeftPoint: PositionLatLng.fromJson(json["topLeftPoint"]),
        btmRightPoint: PositionLatLng.fromJson(json["btmRightPoint"]),
      );

  Map<String, dynamic> toJson() => {
        "topLeftPoint": topLeftPoint.toJson(),
        "btmRightPoint": btmRightPoint.toJson(),
      };
}
