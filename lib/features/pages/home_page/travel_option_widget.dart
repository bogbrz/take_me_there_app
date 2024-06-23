import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_me_there_app/features/pages/home_page/options_list.dart';

class TravelOptionWidget extends HookConsumerWidget {
  const TravelOptionWidget({
    required this.pickUpPlace,
    required this.destinationPlace,
    required this.destination,
    required this.pickUp,
    required this.distance,
    super.key,
  });
  final String pickUpPlace;
  final String destinationPlace;
  final LatLng? pickUp;
  final LatLng? destination;
  final double distance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Column(
        children: [
          Text("Choose your service"),
          Expanded(
            child: ListView(children: [
              for (final option in optionsList) ...[
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                          height: 100,
                          child: Image(image: AssetImage(option.image))),
                      Text(option.name),
                      Text(
                          "${(option.payRate * (distance / 1000)).toStringAsFixed(2)} ${option.currency}")
                    ],
                  ),
                )
              ]
            ]),
          )
        ],
      ),
    );
  }
}
