import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:take_me_there_app/domain/models/user_model.dart';

@injectable
class AuthDataSource {
  final auth = FirebaseAuth.instance;

  Stream<User?> authStateChanges() {
    return auth.authStateChanges();
  }

  Future<User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      auth.currentUser!.updateDisplayName(username);
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

  Future<User?> getUser() async {
    print("DATA SOURCE ${auth.currentUser}");
    return auth.currentUser;
    ;

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
