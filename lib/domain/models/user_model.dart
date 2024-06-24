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
    required GeoPoint? localization,
    required GeoPoint? destination,
    required double distance,
    @Default(false) bool findRoute,
    @Default(false) bool optionChosen,
    @Default(false) bool lookingForDriver,
  }) = _UserModel;
}
