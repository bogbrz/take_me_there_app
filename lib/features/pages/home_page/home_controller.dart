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

final userStreamProvider = StreamProvider.autoDispose(
    (ref) => ref.watch(authDataSourceProvider).getUserById());

class DriverUsersController extends StreamNotifier {
  @override
  Stream build() {
    return ref.watch(authDataSourceProvider).getDriverUsers();
  }
}

final driverUsersStreamProvider = StreamProvider.autoDispose(
    (ref) => ref.watch(authDataSourceProvider).getDriverUsers());

class Clients extends StreamNotifier {
  @override
  Stream build() {
    return ref.watch(authDataSourceProvider).getClientUsers();
  }
}

final clientUsersStreamProvider = StreamProvider.autoDispose(
    (ref) => ref.watch(authDataSourceProvider).getClientUsers());

class Rides extends StreamNotifier {
  @override
  Stream build() {
    return ref.watch(authDataSourceProvider).getRides();
  }
}

final ridesStreamProvider = StreamProvider.autoDispose(
    (ref) => ref.watch(authDataSourceProvider).getRides());

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

  Future<List<LatLng>> getDriverRoute({
    required LatLng start,
    required LatLng end,
  }) async {
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

    return route;
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

  void updateOptionChosen(
      {required String userId, required bool optionChosen}) async {
    ref
        .read(authDataSourceProvider)
        .updateOptionChosen(userId: userId, optionChosen: optionChosen);
  }

  void updateLookingForDriver(
      {required String userId,
      required bool lookingForDriver,
      required GeoPoint pickUpPlace,
      required GeoPoint destination}) async {
    ref.read(authDataSourceProvider).updateLookingForDriver(
        userId: userId,
        lookingForDriver: lookingForDriver,
        pickUpPlace: pickUpPlace,
        destination: destination);
  }

  void updateSettingPickUp(
      {required String userId, required bool settingPickUp}) async {
    ref
        .read(authDataSourceProvider)
        .updateSettingPickUp(userId: userId, settingPickUp: settingPickUp);
  }

  void acceptRide(
      {required String driverId,
      required String rideId,
      required GeoPoint driverLocation,
      required bool acceptedRide}) {
    ref.read(authDataSourceProvider).acceptRide(
        driverId: driverId,
        rideId: rideId,
        driverLocation: driverLocation,
        acceptedRide: acceptedRide);
  }

  void driverConfirm({
    required String rideId,
  }) {
    ref.read(authDataSourceProvider).driverConfirm(
          rideId: rideId,
        );
  }

  void passengerConfirm({
    required String rideId,
  }) {
    ref.read(authDataSourceProvider).passengerConfirm(
          rideId: rideId,
        );
  }

  void resetValues({
    required String userId,
  }) async {
    ref.read(authDataSourceProvider).resetValues(
          userId: userId,
        );
  }

  bool isWirting(bool? writing) {
    if (writing ==null || writing) {
      return false;
    } else {
      return true;
    }
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
