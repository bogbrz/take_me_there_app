import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:take_me_there_app/domain/models/user_model.dart';
import 'package:take_me_there_app/providers/auth_provider.dart';

//
@riverpod
class UserTest extends AsyncNotifier<UserModel> {
  @override
  Future<UserModel> build() async {
    return UserModel(
        localization: GeoPoint(37.43296265331129, -122.08832357078792),
        email: "user!.email.toString()",
        username: "user.displayName.toString()",
        phoneNumber: "user.photoURL.toString()",
        userType: "s",
        id: "1",
        destination: GeoPoint(37.43296265331129, -122.08832357078792),
        distance: 0);
  }
}

class StreamTest extends StreamNotifier {
  @override
  Stream build() {
    return ref.watch(authDataSourceProvider).getUserById();
  }
}
