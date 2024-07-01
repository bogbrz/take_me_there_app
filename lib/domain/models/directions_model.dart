// To parse this JSON data, do
//
//     final welcomeDirections = welcomeDirectionsFromJson(jsonString);

import 'dart:convert';

WelcomeDirections welcomeDirectionsFromJson(String str) => WelcomeDirections.fromJson(json.decode(str));



class WelcomeDirections {
    String type;
    List<double> bbox;
    List<Feature> features;
    Metadata metadata;

    WelcomeDirections({
        required this.type,
        required this.bbox,
        required this.features,
        required this.metadata,
    });

    factory WelcomeDirections.fromJson(Map<String, dynamic> json) => WelcomeDirections(
        type: json["type"],
        bbox: List<double>.from(json["bbox"].map((x) => x?.toDouble())),
        features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
        metadata: Metadata.fromJson(json["metadata"]),
    );

  
}

class Feature {
    List<double> bbox;
    String type;
    Properties properties;
    Geometry geometry;

    Feature({
        required this.bbox,
        required this.type,
        required this.properties,
        required this.geometry,
    });

    factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        bbox: List<double>.from(json["bbox"].map((x) => x?.toDouble())),
        type: json["type"],
        properties: Properties.fromJson(json["properties"]),
        geometry: Geometry.fromJson(json["geometry"]),
    );

   
}

class Geometry {
    List<List<double>> coordinates;
    String type;

    Geometry({
        required this.coordinates,
        required this.type,
    });

    factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: List<List<double>>.from(json["coordinates"].map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
        type: json["type"],
    );

   
}

class Properties {
    List<Segment> segments;
    Summary summary;
    List<int> wayPoints;

    Properties({
        required this.segments,
        required this.summary,
        required this.wayPoints,
    });

    factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        segments: List<Segment>.from(json["segments"].map((x) => Segment.fromJson(x))),
        summary: Summary.fromJson(json["summary"]),
        wayPoints: List<int>.from(json["way_points"].map((x) => x)),
    );

  
}

class Segment {
    double distance;
    double duration;
    List<Step> steps;

    Segment({
        required this.distance,
        required this.duration,
        required this.steps,
    });

    factory Segment.fromJson(Map<String, dynamic> json) => Segment(
        distance: json["distance"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
        steps: List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
    );

   
}

class Step {
    double distance;
    double duration;
    int type;
    String instruction;
    String name;
    List<int> wayPoints;

    Step({
        required this.distance,
        required this.duration,
        required this.type,
        required this.instruction,
        required this.name,
        required this.wayPoints,
    });

    factory Step.fromJson(Map<String, dynamic> json) => Step(
        distance: json["distance"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
        type: json["type"],
        instruction: json["instruction"],
        name: json["name"],
        wayPoints: List<int>.from(json["way_points"].map((x) => x)),
    );


}

class Summary {
    double distance;
    double duration;

    Summary({
        required this.distance,
        required this.duration,
    });

    factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        distance: json["distance"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
    );

   
}

class Metadata {
    String attribution;
    String service;
    int timestamp;
    Query query;
    Engine engine;

    Metadata({
        required this.attribution,
        required this.service,
        required this.timestamp,
        required this.query,
        required this.engine,
    });

    factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        attribution: json["attribution"],
        service: json["service"],
        timestamp: json["timestamp"],
        query: Query.fromJson(json["query"]),
        engine: Engine.fromJson(json["engine"]),
    );

   
}

class Engine {
    String version;
    DateTime buildDate;
    DateTime graphDate;

    Engine({
        required this.version,
        required this.buildDate,
        required this.graphDate,
    });

    factory Engine.fromJson(Map<String, dynamic> json) => Engine(
        version: json["version"],
        buildDate: DateTime.parse(json["build_date"]),
        graphDate: DateTime.parse(json["graph_date"]),
    );

   
}

class Query {
    List<List<double>> coordinates;
    String profile;
    String format;

    Query({
        required this.coordinates,
        required this.profile,
        required this.format,
    });

    factory Query.fromJson(Map<String, dynamic> json) => Query(
        coordinates: List<List<double>>.from(json["coordinates"].map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
        profile: json["profile"],
        format: json["format"],
    );

}
