// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    Summary summary;
    List<Result> results;

    Welcome({
        required this.summary,
        required this.results,
    });

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        summary: Summary.fromJson(json["summary"]),
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "summary": summary.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    String type;
    String id;
    double score;
    Address address;
    PositionLatLng position;
    Viewport viewport;
    List<EntryPoint> entryPoints;
    String? info;
    Poi? poi;

    Result({
        required this.type,
        required this.id,
        required this.score,
        required this.address,
        required this.position,
        required this.viewport,
        required this.entryPoints,
        this.info,
        this.poi,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        type: json["type"],
        id: json["id"],
        score: json["score"]?.toDouble(),
        address: Address.fromJson(json["address"]),
        position: PositionLatLng.fromJson(json["position"]),
        viewport: Viewport.fromJson(json["viewport"]),
        entryPoints: List<EntryPoint>.from(json["entryPoints"].map((x) => EntryPoint.fromJson(x))),
        info: json["info"],
        poi: json["poi"] == null ? null : Poi.fromJson(json["poi"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "score": score,
        "address": address.toJson(),
        "position": position.toJson(),
        "viewport": viewport.toJson(),
        "entryPoints": List<dynamic>.from(entryPoints.map((x) => x.toJson())),
        "info": info,
        "poi": poi?.toJson(),
    };
}

class Address {
    String? streetNumber;
    String streetName;
    String municipalitySubdivision;
    String municipality;
    String countrySecondarySubdivision;
    String countrySubdivision;
    String countrySubdivisionName;
    String countrySubdivisionCode;
    String postalCode;
    String countryCode;
    String country;
    String countryCodeIso3;
    String freeformAddress;
    String localName;

    Address({
        this.streetNumber,
        required this.streetName,
        required this.municipalitySubdivision,
        required this.municipality,
        required this.countrySecondarySubdivision,
        required this.countrySubdivision,
        required this.countrySubdivisionName,
        required this.countrySubdivisionCode,
        required this.postalCode,
        required this.countryCode,
        required this.country,
        required this.countryCodeIso3,
        required this.freeformAddress,
        required this.localName,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        streetNumber: json["streetNumber"],
        streetName: json["streetName"],
        municipalitySubdivision: json["municipalitySubdivision"],
        municipality: json["municipality"],
        countrySecondarySubdivision: json["countrySecondarySubdivision"],
        countrySubdivision: json["countrySubdivision"],
        countrySubdivisionName: json["countrySubdivisionName"],
        countrySubdivisionCode: json["countrySubdivisionCode"],
        postalCode: json["postalCode"],
        countryCode: json["countryCode"],
        country: json["country"],
        countryCodeIso3: json["countryCodeISO3"],
        freeformAddress: json["freeformAddress"],
        localName: json["localName"],
    );

    Map<String, dynamic> toJson() => {
        "streetNumber": streetNumber,
        "streetName": streetName,
        "municipalitySubdivision": municipalitySubdivision,
        "municipality": municipality,
        "countrySecondarySubdivision": countrySecondarySubdivision,
        "countrySubdivision": countrySubdivision,
        "countrySubdivisionName": countrySubdivisionName,
        "countrySubdivisionCode": countrySubdivisionCode,
        "postalCode": postalCode,
        "countryCode": countryCode,
        "country": country,
        "countryCodeISO3": countryCodeIso3,
        "freeformAddress": freeformAddress,
        "localName": localName,
    };
}

class EntryPoint {
    String type;
    PositionLatLng position;

    EntryPoint({
        required this.type,
        required this.position,
    });

    factory EntryPoint.fromJson(Map<String, dynamic> json) => EntryPoint(
        type: json["type"],
        position: PositionLatLng.fromJson(json["position"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "position": position.toJson(),
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

class Poi {
    String name;
    List<CategorySet> categorySet;
    List<String> categories;
    List<Classification> classifications;

    Poi({
        required this.name,
        required this.categorySet,
        required this.categories,
        required this.classifications,
    });

    factory Poi.fromJson(Map<String, dynamic> json) => Poi(
        name: json["name"],
        categorySet: List<CategorySet>.from(json["categorySet"].map((x) => CategorySet.fromJson(x))),
        categories: List<String>.from(json["categories"].map((x) => x)),
        classifications: List<Classification>.from(json["classifications"].map((x) => Classification.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "categorySet": List<dynamic>.from(categorySet.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "classifications": List<dynamic>.from(classifications.map((x) => x.toJson())),
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

class Summary {
    String query;
    String queryType;
    int queryTime;
    int numResults;
    int offset;
    int totalResults;
    int fuzzyLevel;
    List<dynamic> queryIntent;

    Summary({
        required this.query,
        required this.queryType,
        required this.queryTime,
        required this.numResults,
        required this.offset,
        required this.totalResults,
        required this.fuzzyLevel,
        required this.queryIntent,
    });

    factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        query: json["query"],
        queryType: json["queryType"],
        queryTime: json["queryTime"],
        numResults: json["numResults"],
        offset: json["offset"],
        totalResults: json["totalResults"],
        fuzzyLevel: json["fuzzyLevel"],
        queryIntent: List<dynamic>.from(json["queryIntent"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "query": query,
        "queryType": queryType,
        "queryTime": queryTime,
        "numResults": numResults,
        "offset": offset,
        "totalResults": totalResults,
        "fuzzyLevel": fuzzyLevel,
        "queryIntent": List<dynamic>.from(queryIntent.map((x) => x)),
    };
}
