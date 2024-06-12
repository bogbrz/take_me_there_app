import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_me_there_app/data_sources/google_places_data_source.dart';

final googlePlacesDataSourceProvider = Provider<GooglePlacesDataSource>((ref) {
  return GooglePlacesDataSource();
});

final placesProvider = Provider((ref) {
  return ref.read(googlePlacesDataSourceProvider);
});
