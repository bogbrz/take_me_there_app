import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_me_there_app/features/pages/home_page/home_state.dart';
import 'package:take_me_there_app/providers/auth_provider.dart';

class PanelsController extends StreamNotifier {
  @override
  Stream build() {
    return ref.watch(authDataSourceProvider).getWayPoints();
  }
}

final wayPointsProvider = StreamProvider.autoDispose(
    (ref) => ref.watch(authDataSourceProvider).getWayPoints());

class WayPointController extends StateNotifier<HomeState> {
  WayPointController(this.ref) : super(const HomeStateInitial());

  final Ref ref;

  void removeWayPoint({required String wayPointId}) async {
    await ref
        .read(authDataSourceProvider)
        .deleteWayPoint(wayPointId: wayPointId);
  }

  void addWayPoint({
    required int index,
  }) async {
    await ref.read(authDataSourceProvider).addWayPoint(index: index);
  }
}

final wayPointControllerProvider =
    StateNotifierProvider<WayPointController, HomeState>((ref) {
  return WayPointController(ref);
});
