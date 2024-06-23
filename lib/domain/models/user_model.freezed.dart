// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UserModel {
  String get email => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get userType => throw _privateConstructorUsedError;
  GeoPoint? get localization => throw _privateConstructorUsedError;
  GeoPoint? get destination => throw _privateConstructorUsedError;
  double get distance => throw _privateConstructorUsedError;
  bool get findRoute => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String email,
      String username,
      String id,
      String phoneNumber,
      String userType,
      GeoPoint? localization,
      GeoPoint? destination,
      double distance,
      bool findRoute});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? username = null,
    Object? id = null,
    Object? phoneNumber = null,
    Object? userType = null,
    Object? localization = freezed,
    Object? destination = freezed,
    Object? distance = null,
    Object? findRoute = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      userType: null == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String,
      localization: freezed == localization
          ? _value.localization
          : localization // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
      destination: freezed == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      findRoute: null == findRoute
          ? _value.findRoute
          : findRoute // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      String username,
      String id,
      String phoneNumber,
      String userType,
      GeoPoint? localization,
      GeoPoint? destination,
      double distance,
      bool findRoute});
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? username = null,
    Object? id = null,
    Object? phoneNumber = null,
    Object? userType = null,
    Object? localization = freezed,
    Object? destination = freezed,
    Object? distance = null,
    Object? findRoute = null,
  }) {
    return _then(_$UserModelImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      userType: null == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String,
      localization: freezed == localization
          ? _value.localization
          : localization // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
      destination: freezed == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
      findRoute: null == findRoute
          ? _value.findRoute
          : findRoute // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$UserModelImpl implements _UserModel {
  _$UserModelImpl(
      {required this.email,
      required this.username,
      required this.id,
      required this.phoneNumber,
      required this.userType,
      required this.localization,
      required this.destination,
      required this.distance,
      this.findRoute = false});

  @override
  final String email;
  @override
  final String username;
  @override
  final String id;
  @override
  final String phoneNumber;
  @override
  final String userType;
  @override
  final GeoPoint? localization;
  @override
  final GeoPoint? destination;
  @override
  final double distance;
  @override
  @JsonKey()
  final bool findRoute;

  @override
  String toString() {
    return 'UserModel(email: $email, username: $username, id: $id, phoneNumber: $phoneNumber, userType: $userType, localization: $localization, destination: $destination, distance: $distance, findRoute: $findRoute)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.localization, localization) ||
                other.localization == localization) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.findRoute, findRoute) ||
                other.findRoute == findRoute));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, username, id, phoneNumber,
      userType, localization, destination, distance, findRoute);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);
}

abstract class _UserModel implements UserModel {
  factory _UserModel(
      {required final String email,
      required final String username,
      required final String id,
      required final String phoneNumber,
      required final String userType,
      required final GeoPoint? localization,
      required final GeoPoint? destination,
      required final double distance,
      final bool findRoute}) = _$UserModelImpl;

  @override
  String get email;
  @override
  String get username;
  @override
  String get id;
  @override
  String get phoneNumber;
  @override
  String get userType;
  @override
  GeoPoint? get localization;
  @override
  GeoPoint? get destination;
  @override
  double get distance;
  @override
  bool get findRoute;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
