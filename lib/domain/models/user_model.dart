import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:take_me_there_app/features/pages/user_page/user.dart';

part 'user_model.freezed.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required User? user,
  }) = _UserModel;


}
