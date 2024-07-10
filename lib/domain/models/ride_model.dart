import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ride_model.freezed.dart';

@freezed
class RideModel with _$RideModel {
  factory RideModel(
      {required GeoPoint destination,
      required GeoPoint pickUpLocation,
      required String passagerId,
      required String? driverId,
      required GeoPoint? driverLocation,
      required String rideId,
      required bool acceptedRide}) = _RideModel;
}
