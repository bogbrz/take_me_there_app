import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthDataSource {
  final auth = FirebaseAuth.instance;

  Stream<User?> authStateChanges() {
    return auth.authStateChanges();
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
  }) async {
    auth.createUserWithEmailAndPassword(email: email, password: password);
    auth.currentUser!.updateDisplayName(username);
  }

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    auth.signInWithEmailAndPassword(email: email, password: password);
  }
}
