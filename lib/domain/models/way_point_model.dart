import 'package:freezed_annotation/freezed_annotation.dart';

part 'way_point_model.freezed.dart';

@freezed
class WayPointModel with _$WayPointModel {
  factory WayPointModel({
    required String start,
    required String destination, 
    required String  id,
    required int index,

    
  }) = _WayPointModel;
}
