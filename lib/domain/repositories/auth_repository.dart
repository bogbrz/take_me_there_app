import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:take_me_there_app/data_sources/auth_data_source.dart';

@injectable
class AuthRepository {
  final AuthDataSource dataSource;

  AuthRepository({required this.dataSource});
  Stream<User?> authStateChanges() {
    return dataSource.authStateChanges();
  }

  void createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String username,
  }) async {
    dataSource.createUserWithEmailAndPassword(
        email: email, password: password, username: username);
  }

  void signInWithEmailAndPassword(
      {required String email, required String password}) async {
    dataSource.signInWithEmailAndPassword(email: email, password: password);
  }
}
