import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:take_me_there_app/domain/models/user_model.dart';
import 'package:take_me_there_app/domain/repositories/auth_repository.dart';

class LoginPageController extends StateNotifier<UserModel> {
  LoginPageController(super._state, {required this.authRepository});
  final AuthRepository authRepository;


}
