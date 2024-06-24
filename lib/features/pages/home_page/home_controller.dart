import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_me_there_app/domain/models/place_model.dart';

import 'package:take_me_there_app/features/pages/home_page/home_state.dart';
import 'package:take_me_there_app/providers/auth_provider.dart';
import 'package:take_me_there_app/providers/google_places_provider.dart';

class HomeController extends StreamNotifier {
  @override
  Stream build() {
    return ref.watch(authDataSourceProvider).getUserById();
  }
}

final userStreamProvider =
    StreamProvider((ref) => ref.watch(authDataSourceProvider).getUserById());

class LocationController extends StateNotifier<HomeState> {
  LocationController(this.ref) : super(const HomeStateInitial());

  final Ref ref;

  void updateLocation({required String userId}) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    GeoPoint geoPoint = GeoPoint(position.latitude, position.longitude);
    ref
        .read(authDataSourceProvider)
        .updateLocalization(location: geoPoint, userId: userId);
  }
}

final locationControllerProvider = StateNotifierProvider((ref) {
  return LocationController(ref);
});

class SuggestionController extends StateNotifier<HomeState> {
  SuggestionController(this.ref) : super(const HomeStateInitial());

  final Ref ref;

  Future<List<Result>?> getSuggestions({required String address}) async {
    state = const HomeStateLoading();

    final results =
        await ref.read(placesDataSourceProvider).getSuggestions(address);
    if (results == null) {
      print("NULLL");
      return null;
    }

    final welcomeResults = results.results;

    // final descriptions = <String>[];
    // for (final result in welcomeResults) {
    //   descriptions.add(result.);
    //   print("DESCRIPTION $descriptions");
    // }
    return welcomeResults;
  }

  Future<List<LatLng>> getRoute(
      {required LatLng start,
      required LatLng end,
      required String userId}) async {
    state = const HomeStateLoading();
    final results = await ref
        .read(placesDataSourceProvider)
        .getRoute(start: start, end: end);
    final features = results.features;
    final coordList = features[0].geometry.coordinates;

    final List<LatLng> route = [];

    for (int i = 0; i < coordList.length; i++) {
      route.add(LatLng(coordList[i][1], coordList[i][0]));
    }
    print("Controller : ${route}");
    ref.read(authDataSourceProvider).updateDistance(
        distance: results.features[0].properties.segments[0].distance,
        userId: userId);
    return route;
  }

  void updateLocation({required String userId}) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    GeoPoint geoPoint = GeoPoint(position.latitude, position.longitude);
    ref
        .read(authDataSourceProvider)
        .updateLocalization(location: geoPoint, userId: userId);
  }

  void updateOptionChosen({required String userId, required bool optionChosen}) async {
   
  
    ref
        .read(authDataSourceProvider)
        .updateOptionChosen( userId: userId, optionChosen: optionChosen);
  }

  void updateLookingForDriver({required String userId, required bool lookingForDriver}) async {
   
  
    ref
        .read(authDataSourceProvider)
        .updateLookingForDriver( userId: userId, lookingForDriver: lookingForDriver);
  }

  void updateDestination(
      {required String userId,
      required GeoPoint? localization,
      required GeoPoint destination}) async {
    if (localization == null) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      GeoPoint geoPoint = GeoPoint(position.latitude, position.longitude);
      ref.read(authDataSourceProvider).addPickUpAndDestination(
          location: geoPoint, userId: userId, destination: destination);
    } else {
      ref.read(authDataSourceProvider).addPickUpAndDestination(
          location: localization, userId: userId, destination: destination);
    }
  }
}

final suggestionControllerProvider =
    StateNotifierProvider<SuggestionController, HomeState>((ref) {
  return SuggestionController(ref);
});
