import 'package:freezed_annotation/freezed_annotation.dart';

part 'distance_model.freezed.dart';

@freezed
class DistanceModel with _$DistanceModel {
  factory DistanceModel({
    required String rideId,
   required double distance,


    
  }) = _DistanceModel;
}
