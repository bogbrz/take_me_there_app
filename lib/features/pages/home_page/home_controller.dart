import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_me_there_app/domain/models/place_suggestion_model.dart';
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

  Future<List<String>?> getSuggestions({required String address}) async {
    state = const HomeStateLoading();

    final results =
        await ref.read(googlePlacesDataSourceProvider).getSuggestions(address);
    if (results == null) {
      print("NULLL");
      return null;
    }
    final welomeModel = Welcome.fromJson(results);
    final predicitons = welomeModel.predictions;
    final descriptions = <String>[];
    for (final prediction in predicitons) {
      descriptions.add(prediction.description);
      print("DESCRIPTION $descriptions");
    }
    return descriptions;
  }

  void updateLocation({required String userId}) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    GeoPoint geoPoint = GeoPoint(position.latitude, position.longitude);
    ref
        .read(authDataSourceProvider)
        .updateLocalization(location: geoPoint, userId: userId);
  }
   void updateDestination({required String userId}) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    GeoPoint geoPoint = GeoPoint(position.latitude, position.longitude);
    ref
        .read(authDataSourceProvider)
        .updateLocalization(location: geoPoint, userId: userId);
  }
}

final suggestionControllerProvider =
    StateNotifierProvider<SuggestionController, HomeState>((ref) {
  return SuggestionController(ref);
});
