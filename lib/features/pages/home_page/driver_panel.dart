import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_me_there_app/domain/models/distance_calculate_model.dart';
import 'package:take_me_there_app/domain/models/distance_model.dart';
import 'package:take_me_there_app/features/pages/home_page/home_controller.dart';

class DriverPanel extends HookConsumerWidget {
  DriverPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userStreamProvider).value![0];

    final rides = ref.watch(ridesStreamProvider).value ?? [];

    final shortestDistance = useState<double?>(null);

    final listOfDistances = useState<List<DistanceModel>>([]);

    final closestDistanceModel = useState<List<DistanceModel>?>(null);

    final closestRide = rides
        .where((element) =>
            element.rideId == closestDistanceModel.value?[0].rideId)
        .toList();

    final List<CalculateModel> calculateModels = rides
        .map((e) => CalculateModel(
              rideId: e.rideId,
              coordinates:
                  LatLng(e.pickUpLocation.latitude, e.pickUpLocation.longitude),
            ))
        .toList();

    double calculateDistance(
        {required LatLng pickUp, required LatLng userLocation}) {
      final lat1 = pickUp.latitude;
      final lon1 = pickUp.longitude;
      final lat2 = userLocation.latitude;
      final lon2 = userLocation.longitude;
      final p = 0.017453292519943295;
      final c = cos;
      final a = 0.5 -
          c((lat2 - lat1) * p) / 2 +
          c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
      return 12742 * asin(sqrt(a));
    }

    void getDistances(
        {required List<CalculateModel> pickUps, required LatLng userLocation}) {
      for (final pickUp in pickUps) {
        listOfDistances.value.add(DistanceModel(
            rideId: pickUp.rideId,
            distance: calculateDistance(
                pickUp: pickUp.coordinates, userLocation: userLocation)));
      }
    }

    void getShortestDistance({required List<DistanceModel> distanceModels}) {
      List<double> distances = [];
      for (final distanceModel in distanceModels) {
        distances.add(distanceModel.distance);
      }
      shortestDistance.value = distances.reduce(min);
      closestDistanceModel.value = distanceModels
          .where((element) => element.distance == shortestDistance.value)
          .toList();
    }

    void calculations() {
      getDistances(
          pickUps: calculateModels,
          userLocation: LatLng(
              user.localization!.latitude, user.localization!.longitude));

      getShortestDistance(distanceModels: listOfDistances.value);
    }

    useEffect(() {
      calculations();
    });

    print("RIDES  $rides");

    return Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04,
            vertical: MediaQuery.of(context).size.width * 0.025),
        decoration: BoxDecoration(
            color: Color.fromARGB(173, 0, 0, 0),
            borderRadius: BorderRadius.circular(10)),
        height: MediaQuery.of(context).size.height * 0.33,  
        // width: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            Text("Driver Panel"),
            Expanded(
              child: ListView.builder(
                  itemCount: closestRide.length,
                  itemBuilder: ((context, index) {
                    final ride = closestRide[index];
                    return Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(ride.passagerId), Text(ride.driverId!)],
                      ),
                    );
                  })),
            )
          ],
        ));
  }
}
