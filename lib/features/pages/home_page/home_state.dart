import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeStateInitial extends HomeState {
  const HomeStateInitial();

  @override
  List<Object> get props => [];
}

class HomeStateLoading extends HomeState {
  const HomeStateLoading();

  @override
  List<Object> get props => [];
}

class HomeStateSuccess extends HomeState {
   final List<String> suggestions;

  const HomeStateSuccess(this.suggestions);

  @override
  List<Object> get props => [suggestions];
}

class HomeStateError extends HomeState {
  final String error;

  const HomeStateError(this.error);

  @override
  List<Object> get props => [error];
}
