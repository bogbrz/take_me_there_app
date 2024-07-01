import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'distance_calculate_model.freezed.dart';

@freezed
class CalculateModel with _$CalculateModel {
  factory CalculateModel({
    required String rideId,
   required LatLng coordinates,


    
  }) = _CalculateModel;
}
