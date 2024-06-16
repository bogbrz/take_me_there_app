import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_me_there_app/data_sources/places_data_source.dart';

final placesDataSourceProvider = Provider<PlacesDataSource>((ref) {
  return PlacesDataSource();
});

final placesProvider = Provider((ref) {
  return ref.read(placesDataSourceProvider);
});
