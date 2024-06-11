// import 'package:dio/dio.dart';
// import 'package:injectable/injectable.dart';
// import 'package:take_me_there_app/domain/models/place_suggestion_model.dart';
// import 'package:take_me_there_app/map_config/google_maps_dependecy.dart';

// class GooglePlacesDataSource {
//   String _token = "37465";
//   void makeSuggestion(String adress) async {
//     String googlePlacesApiKey = key;
//     String groundURL =
//         'https://maps.googleapis.com/maps/api/place/autocomplete/json';
//     String request =
//         '$groundURL?input=$adress&key=$googlePlacesApiKey&sessiontoken=$_token';
//     Response response;
//     response = await Dio().get(request);
//   }
// }

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:take_me_there_app/domain/models/place_suggestion_model.dart';
part 'google_places_data_source.g.dart';


@injectable
@RestApi()
abstract class GooglePlacesDataSource {
  @factoryMethod
  factory GooglePlacesDataSource(Dio dio) = _GooglePlacesDataSource;

  @GET('')
  Future<Welcome> getSuggestions( @Query('input') String adress,);
}
