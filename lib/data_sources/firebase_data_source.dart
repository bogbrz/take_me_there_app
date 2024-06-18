import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:take_me_there_app/app/core/enums.dart';
import 'package:take_me_there_app/domain/models/user_model.dart';

@injectable
class AuthDataSource {
  final auth = FirebaseAuth.instance;
  final dataBase = FirebaseFirestore.instance;

  Stream<User?> authStateChanges() {
    return auth.authStateChanges();
  }

  Future<User?> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String username,
      required UserType userType,
      required String phoneNumber,
      required}) async {
    try {
      final result = await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((_) async {
        await auth.currentUser!.updateDisplayName(username);
      }).then((_) async {
        await dataBase.collection("users").add({
          "username": auth.currentUser!.displayName,
          "userType": userType.toString(),
          "email": email,
          "uid": auth.currentUser!.uid,
          "phoneNumber": phoneNumber,
          "localization": GeoPoint(0, 0),
          "destination": GeoPoint(0, 0)
        });
      });

      return result.user;
    } catch (e) {
      throw Exception("Error");
    }
  }

  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('User not found');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Wrong password');
      } else {
        throw AuthException('An error occured. Please try again later');
      }
    }
  }

  Future<void> updateLocalization(
      {required GeoPoint location, required String userId}) {
    return FirebaseFirestore.instance.collection("users").doc(userId).update({
      "localization": location,
    });
  }

  Future<void> addPickUpAndDestination(
      {required GeoPoint location,
      required String userId,
      required GeoPoint destination}) {
    return FirebaseFirestore.instance.collection("users").doc(userId).update({
      "localization": location,
      "destination": destination,
    });
  }

  Stream<List<UserModel>> getUserById() {
    return FirebaseFirestore.instance.collection("users").snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => UserModel(
                email: doc["email"],
                username: doc["username"],
                id: doc.id,
                phoneNumber: doc["phoneNumber"],
                userType: doc["userType"],
                localization: doc["localization"],
                destination: doc["destination"]))
            .where((element) =>
                element.email.toString() == auth.currentUser!.email.toString())
            .toList());
  }

  Future<User?> getUser() async {
    print("DATA SOURCE ${auth.currentUser}");
    return auth.currentUser;

    // if (user == null) {
    //   throw Exception("User not logged in");
    // } else {
    //   return UserModel(
    //       email: "dupa", username: user.displayName!, pictureUrl: "pictureUrl");
    // }
  }

  void signOut() {
    auth.signOut();
  }
}

class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() {
    return message;
  }
}
