// import 'package:dio/dio.dart';
// import 'package:injectable/injectable.dart';
// import 'package:take_me_there_app/domain/models/place_suggestion_model.dart';
// import 'package:take_me_there_app/map_config/google_maps_dependecy.dart';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
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
  String _token = "37465";
  Future<Map<String, dynamic>?> getSuggestions(String adress) async {
    String apiKey = freeKey;
    String groundURL =
        'https://{baseURL}/search/{versionNumber}/search/{query} .{ext}?key=DSb8iW2Kl0nyrvAwto7FeVrQ5AZRKwFG';
    String request =
        "https://api.tomtom.com/search/2/search/$adress.json?key=$apiKey";

    final result = await Dio().get<Map<String, dynamic>>(request);
    final resultData = result.data;
    print("DATA SOURCE  $resultData");

    return resultData;
  }
}
