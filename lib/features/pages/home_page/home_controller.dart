import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_me_there_app/features/pages/home_page/home_state.dart';
import 'package:take_me_there_app/providers/auth_provider.dart';

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
