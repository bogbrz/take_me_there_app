import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'way_point_model.freezed.dart';

@freezed
class WayPointModel with _$WayPointModel {
  factory WayPointModel({
    required GeoPoint start,
    required GeoPoint destination, 
    required String  id,
    required int index,

    
  }) = _WayPointModel;
}
