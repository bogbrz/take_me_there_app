import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:take_me_there_app/app/core/enums.dart';
import 'package:take_me_there_app/domain/models/ride_model.dart';
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
          "destination": GeoPoint(0, 0),
          "findRoute": false,
          "distance": 0,
          "optionChosen": false,
          "lookingForDriver": false,
          "settingPickUp": false,
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

  Future<void> resetValues({required String userId}) {
    return FirebaseFirestore.instance.collection("users").doc(userId).update({
      "findRoute": false,
      "lookingForDriver": false,
      "distance": 0,
      "optionChosen": false,
      "settingPickUp": false,
    });
  }

  Future<void> updateDistance(
      {required double distance, required String userId}) {
    return FirebaseFirestore.instance.collection("users").doc(userId).update({
      "distance": distance,
    });
  }

  Future<void> addPickUpAndDestination(
      {required GeoPoint location,
      required String userId,
      required GeoPoint destination}) {
    return FirebaseFirestore.instance.collection("users").doc(userId).update({
      "localization": location,
      "destination": destination,
      "findRoute": true
    });
  }

  Future<void> updateOptionChosen(
      {required String userId, required bool optionChosen}) {
    return FirebaseFirestore.instance.collection("users").doc(userId).update({
      "optionChosen": true,
    });
  }

  Future<void> updateLookingForDriver(
      {required String userId,
      required bool lookingForDriver,
      required GeoPoint pickUpPlace,
      required GeoPoint destination}) {
    FirebaseFirestore.instance.collection("users").doc(userId).update({
      "lookingForDriver": lookingForDriver,
      "localization": pickUpPlace,
      "settingPickUp": false
    });
    return FirebaseFirestore.instance.collection("rides").add({
      "passagerId": userId,
      "pickUpLocation": pickUpPlace,
      "destination": destination,
      "driverId": "",
      "driverLocation": null,
      "acceptedRide": false,
    });
  }

  Future<void> updateSettingPickUp(
      {required String userId, required bool settingPickUp}) {
    return FirebaseFirestore.instance.collection("users").doc(userId).update({
      "settingPickUp": settingPickUp,
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
                destination: doc["destination"],
                distance: doc["distance"] + 0.0,
                findRoute: doc["findRoute"],
                optionChosen: doc["optionChosen"],
                lookingForDriver: doc["lookingForDriver"],
                settingPickUp: doc["settingPickUp"]))
            .where((element) =>
                element.email.toString() == auth.currentUser!.email.toString())
            .toList());
  }

  Stream<List<UserModel>> getDriverUsers() {
    return FirebaseFirestore.instance.collection("users").snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => UserModel(
                email: doc["email"],
                username: doc["username"],
                id: doc.id,
                phoneNumber: doc["phoneNumber"],
                userType: doc["userType"],
                localization: doc["localization"],
                destination: doc["destination"],
                distance: doc["distance"] + 0.0,
                findRoute: doc["findRoute"],
                optionChosen: doc["optionChosen"],
                lookingForDriver: doc["lookingForDriver"],
                settingPickUp: doc["settingPickUp"]))
            .where((element) =>
                element.userType.toString() == UserType.driver.toString())
            .toList());
  }

  Stream<List<UserModel>> getClientUsers() {
    return FirebaseFirestore.instance.collection("users").snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => UserModel(
                email: doc["email"],
                username: doc["username"],
                id: doc.id,
                phoneNumber: doc["phoneNumber"],
                userType: doc["userType"],
                localization: doc["localization"],
                destination: doc["destination"],
                distance: doc["distance"] + 0.0,
                findRoute: doc["findRoute"],
                optionChosen: doc["optionChosen"],
                lookingForDriver: doc["lookingForDriver"],
                settingPickUp: doc["settingPickUp"]))
            .where((element) =>
                element.userType.toString() == UserType.client.toString())
            .toList());
  }

  Stream<List<RideModel>> getRides() {
    return FirebaseFirestore.instance.collection("rides").snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => RideModel(
                acceptedRide: doc["acceptedRide"],
                destination: doc["destination"],
                pickUpLocation: doc["pickUpLocation"],
                passagerId: doc["passagerId"],
                driverId: doc["driverId"],
                driverLocation: doc["driverLocation"],
                rideId: doc.id))
            .toList());
  }

  Future<void> acceptRide(
      {required String driverId,
      required String rideId,
      required GeoPoint driverLocation,
      acceptedRide}) async {
    return FirebaseFirestore.instance.collection("rides").doc(rideId).update({
      "driverId": driverId,
      "driverLocation": driverLocation,
      "acceptedRide": acceptedRide
    });
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
