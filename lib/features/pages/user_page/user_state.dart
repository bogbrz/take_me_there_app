import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserStateInitial extends UserState {
  const UserStateInitial();

  @override
  List<Object> get props => [];
}

class UserStateLoading extends UserState {
  const UserStateLoading();

  @override
  List<Object> get props => [];
}

class UserStateSuccess extends UserState {
  const UserStateSuccess();

  @override
  List<Object> get props => [];
}

class UserStateError extends UserState {
  final String error;

  const UserStateError(this.error);

  @override
  List<Object> get props => [error];
}
