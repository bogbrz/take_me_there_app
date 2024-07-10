import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_me_there_app/domain/models/distance_calculate_model.dart';
import 'package:take_me_there_app/domain/models/distance_model.dart';
import 'package:take_me_there_app/domain/models/ride_model.dart';
import 'package:take_me_there_app/features/pages/home_page/home_controller.dart';

class DriverPanel extends HookConsumerWidget {
  DriverPanel({
    super.key,
  });
    /// TO FIX DISPLAYING AVALIBLE RIDES LOGIC !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listOfDecilendStrings = useState<List<String>>([]);
    final user = ref.watch(userStreamProvider).value![0];

    final rides = ref
            .watch(ridesStreamProvider)
            .value
            ?.where((element) =>
                element.acceptedRide == false &&
                !listOfDecilendStrings.value.contains(element.rideId))
            .toList() ??
        [];

    final clients = ref.watch(clientUsersStreamProvider).value ?? [];

    final shortestDistance = useState<double?>(null);
    final acceptedRide = useState<bool>(false);

    final listOfDistances = useState<List<DistanceModel>>([]);

    final closestDistanceModel = useState<List<DistanceModel>?>(null);
    final rideIndex = useState<int>(0);
    final displayRides = useState<List<RideModel>>([]);

    // final closestRide = rides
    //     .where((element) =>
    //         element.rideId == closestDistanceModel.value?[0].rideId)
    //     .toList();

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

      List<double> distances = [];
      for (final distanceModel in listOfDistances.value) {
        distances.add(distanceModel.distance);
      }
      shortestDistance.value = distances[rideIndex.value];
      closestDistanceModel.value = listOfDistances.value
          .where((element) => element.distance == shortestDistance.value)
          .toList();

      displayRides.value = rides
          .where((element) =>
              element.rideId == closestDistanceModel.value?[0].rideId)
          .toList();
    }

    void getShortestDistance({required List<DistanceModel> distanceModels}) {}

    void calculations() {
      getDistances(
          pickUps: calculateModels,
          userLocation: LatLng(
              user.localization!.latitude, user.localization!.longitude));

      // getShortestDistance(distanceModels: listOfDistances.value);
    }

    useEffect(() {
      if (rides.isNotEmpty) {
        calculations();
      } else {
        null;
      }

      // print(closestDistanceModel.value!);
      // print(closestDistanceModel.value!.length);
      return;
    });

    return Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04,
            vertical: MediaQuery.of(context).size.width * 0.025),
        decoration: BoxDecoration(
            color: Color.fromARGB(173, 0, 0, 0),
            borderRadius: BorderRadius.circular(10)),
        height: acceptedRide.value
            ? MediaQuery.of(context).size.height * 0.1
            : MediaQuery.of(context).size.height * 0.33,
        width: MediaQuery.of(context).size.height * 0.8,
        child: acceptedRide.value == false
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Driver Panel"),
                  Expanded(
                    child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: ((context, index) {
                          if (rides.isNotEmpty) {
                            final ride = displayRides.value[index];

                            return Column(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(),
                                    Text(
                                        "${clients.where((element) => element.id == ride.passagerId).toList()[0].username}")
                                  ],
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            acceptedRide.value = true;
                                            ref
                                                .read(
                                                    suggestionControllerProvider
                                                        .notifier)
                                                .acceptRide(
                                                    acceptedRide:
                                                        acceptedRide.value,
                                                    driverId: user.id,
                                                    rideId: ride.rideId,
                                                    driverLocation:
                                                        user.localization ??
                                                            GeoPoint(0, 0));
                                          },
                                          child: Text("Accept")),
                                      ElevatedButton(
                                          onPressed: () {
                                            listOfDecilendStrings.value
                                                .add(ride.rideId);
                                            rideIndex.value++;
                                          },
                                          child: Text("Decline"))
                                    ])
                              ],
                            );
                          } else {
                            return Center(child: Text("No rides avalible"));
                          }
                        })),
                  )
                ],
              )
            : Text("DRIVING"));
  }
}
