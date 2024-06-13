import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_me_there_app/data_sources/firebase_data_source.dart';

final authDataSourceProvider = Provider<AuthDataSource>((ref) {
  return AuthDataSource();
});

final userProvider = Provider((ref) {
  return ref.read(authDataSourceProvider).getUser();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authDataSourceProvider).authStateChanges();
});



