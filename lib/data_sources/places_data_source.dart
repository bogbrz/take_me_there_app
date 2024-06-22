// import 'package:dio/dio.dart';
// import 'package:injectable/injectable.dart';
// import 'package:take_me_there_app/domain/models/place_suggestion_model.dart';
// import 'package:take_me_there_app/map_config/google_maps_dependecy.dart';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:take_me_there_app/app/env/env.dart';
import 'package:take_me_there_app/domain/models/directions_model.dart';
import 'package:take_me_there_app/domain/models/place_model.dart';

import 'package:take_me_there_app/map_config/google_maps_dependecy.dart';

// part 'google_places_data_source.g.dart';

// @injectable
// @RestApi()
// abstract class PlacesDataSource {
//   @factoryMethod
//   factory PlacesDataSource(Dio dio) = _PlacesDataSource;

//   @GET('/predictions')
//   Future<Welcome> getSuggestions(
//     @Query('input') String adress,
//   );
// }
class PlacesDataSource {
  static final _apiKey = Env.placesKey;
  static final _directionsKey = Env.directionsKey;
  Future<Welcome> getSuggestions(String adress) async {
    String groundURL =
        'https://{baseURL}/search/{versionNumber}/search/{query} .{ext}?key=DSb8iW2Kl0nyrvAwto7FeVrQ5AZRKwFG';
    String request =
        "https://api.tomtom.com/search/2/search/$adress.json?key=$_apiKey&limit=2";

    final result = await Dio().get<Map<String, dynamic>>(request);
    final resultData = result.data;
    final welcome = Welcome.fromJson(resultData!);
    print("DATA SOURCE  $resultData");

    return welcome;
  }

  Future<WelcomeDirections> getRoute(
      {required String startLng,
      required String startLat,
      required String endLng,
      required String endLat}) async {
    final String url =
        "https://api.openrouteservice.org/v2/directions/driving-car?api_key=$_directionsKey&start=$startLat,$startLng&end=$endLat,$endLng";

    final result = await Dio().get<Map<String, dynamic>>(url);

    final resultData = result.data;
    final resultModel = WelcomeDirections.fromJson(resultData!);

    return resultModel;
  }
}

//  "https://api.tomtom.com/search/2/search/query.json?key=DSb8iW2Kl0nyrvAwto7FeVrQ5AZRKwFG&limit=2";

// DSb8iW2Kl0nyrvAwto7FeVrQ5AZRKwFG