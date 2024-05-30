import 'package:firebase_auth/firebase_auth.dart';

class AuthDataSource {
  final auth = FirebaseAuth.instance;

  Stream<User?> authStateChanges() {
    return auth.authStateChanges();
  }

  void createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
  }) async {
    auth.createUserWithEmailAndPassword(email: email, password: password);
    auth.currentUser!.updateDisplayName(username);
  }
}
