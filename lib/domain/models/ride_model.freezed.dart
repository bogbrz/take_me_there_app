// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ride_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RideModel {
  GeoPoint get destination => throw _privateConstructorUsedError;
  GeoPoint get pickUpLocation => throw _privateConstructorUsedError;
  String get passagerId => throw _privateConstructorUsedError;
  String? get driverId => throw _privateConstructorUsedError;
  GeoPoint? get driverLocation => throw _privateConstructorUsedError;
  String get rideId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RideModelCopyWith<RideModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RideModelCopyWith<$Res> {
  factory $RideModelCopyWith(RideModel value, $Res Function(RideModel) then) =
      _$RideModelCopyWithImpl<$Res, RideModel>;
  @useResult
  $Res call(
      {GeoPoint destination,
      GeoPoint pickUpLocation,
      String passagerId,
      String? driverId,
      GeoPoint? driverLocation,
      String rideId});
}

/// @nodoc
class _$RideModelCopyWithImpl<$Res, $Val extends RideModel>
    implements $RideModelCopyWith<$Res> {
  _$RideModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? destination = null,
    Object? pickUpLocation = null,
    Object? passagerId = null,
    Object? driverId = freezed,
    Object? driverLocation = freezed,
    Object? rideId = null,
  }) {
    return _then(_value.copyWith(
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      pickUpLocation: null == pickUpLocation
          ? _value.pickUpLocation
          : pickUpLocation // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      passagerId: null == passagerId
          ? _value.passagerId
          : passagerId // ignore: cast_nullable_to_non_nullable
              as String,
      driverId: freezed == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as String?,
      driverLocation: freezed == driverLocation
          ? _value.driverLocation
          : driverLocation // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
      rideId: null == rideId
          ? _value.rideId
          : rideId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RideModelImplCopyWith<$Res>
    implements $RideModelCopyWith<$Res> {
  factory _$$RideModelImplCopyWith(
          _$RideModelImpl value, $Res Function(_$RideModelImpl) then) =
      __$$RideModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {GeoPoint destination,
      GeoPoint pickUpLocation,
      String passagerId,
      String? driverId,
      GeoPoint? driverLocation,
      String rideId});
}

/// @nodoc
class __$$RideModelImplCopyWithImpl<$Res>
    extends _$RideModelCopyWithImpl<$Res, _$RideModelImpl>
    implements _$$RideModelImplCopyWith<$Res> {
  __$$RideModelImplCopyWithImpl(
      _$RideModelImpl _value, $Res Function(_$RideModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? destination = null,
    Object? pickUpLocation = null,
    Object? passagerId = null,
    Object? driverId = freezed,
    Object? driverLocation = freezed,
    Object? rideId = null,
  }) {
    return _then(_$RideModelImpl(
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      pickUpLocation: null == pickUpLocation
          ? _value.pickUpLocation
          : pickUpLocation // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      passagerId: null == passagerId
          ? _value.passagerId
          : passagerId // ignore: cast_nullable_to_non_nullable
              as String,
      driverId: freezed == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as String?,
      driverLocation: freezed == driverLocation
          ? _value.driverLocation
          : driverLocation // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
      rideId: null == rideId
          ? _value.rideId
          : rideId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RideModelImpl implements _RideModel {
  _$RideModelImpl(
      {required this.destination,
      required this.pickUpLocation,
      required this.passagerId,
      required this.driverId,
      required this.driverLocation,
      required this.rideId});

  @override
  final GeoPoint destination;
  @override
  final GeoPoint pickUpLocation;
  @override
  final String passagerId;
  @override
  final String? driverId;
  @override
  final GeoPoint? driverLocation;
  @override
  final String rideId;

  @override
  String toString() {
    return 'RideModel(destination: $destination, pickUpLocation: $pickUpLocation, passagerId: $passagerId, driverId: $driverId, driverLocation: $driverLocation, rideId: $rideId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RideModelImpl &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.pickUpLocation, pickUpLocation) ||
                other.pickUpLocation == pickUpLocation) &&
            (identical(other.passagerId, passagerId) ||
                other.passagerId == passagerId) &&
            (identical(other.driverId, driverId) ||
                other.driverId == driverId) &&
            (identical(other.driverLocation, driverLocation) ||
                other.driverLocation == driverLocation) &&
            (identical(other.rideId, rideId) || other.rideId == rideId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, destination, pickUpLocation,
      passagerId, driverId, driverLocation, rideId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RideModelImplCopyWith<_$RideModelImpl> get copyWith =>
      __$$RideModelImplCopyWithImpl<_$RideModelImpl>(this, _$identity);
}

abstract class _RideModel implements RideModel {
  factory _RideModel(
      {required final GeoPoint destination,
      required final GeoPoint pickUpLocation,
      required final String passagerId,
      required final String? driverId,
      required final GeoPoint? driverLocation,
      required final String rideId}) = _$RideModelImpl;

  @override
  GeoPoint get destination;
  @override
  GeoPoint get pickUpLocation;
  @override
  String get passagerId;
  @override
  String? get driverId;
  @override
  GeoPoint? get driverLocation;
  @override
  String get rideId;
  @override
  @JsonKey(ignore: true)
  _$$RideModelImplCopyWith<_$RideModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
