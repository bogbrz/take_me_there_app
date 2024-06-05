import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required String email,
    required String username,
    required String id,
    required String phoneNumber,
    required String userType,
    required GeoPoint? geoPoint,
  }) = _UserModel;
}
