import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:take_me_there_app/domain/models/user_model.dart';
import 'package:take_me_there_app/features/pages/user_page/user_state.dart';
import 'package:take_me_there_app/providers/auth_provider.dart';

//
@riverpod
class UserTest extends AsyncNotifier<UserModel> {
  @override
  Future<UserModel> build() async {
    final user = await ref.watch(authDataSourceProvider).getUser();

    return UserModel(
        geoPoint: GeoPoint(37.43296265331129, -122.08832357078792),
        email: user!.email.toString(),
        username: user.displayName.toString(),
        phoneNumber: "user.photoURL.toString()",
        userType: "s",
        id: "1");
  }
}

class StreamTest extends StreamNotifier {
  @override
  Stream build() {
    return ref.watch(authDataSourceProvider).getUserById();
  }
}
