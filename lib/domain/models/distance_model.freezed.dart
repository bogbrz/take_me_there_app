// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'distance_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DistanceModel {
  String get rideId => throw _privateConstructorUsedError;
  double get distance => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DistanceModelCopyWith<DistanceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DistanceModelCopyWith<$Res> {
  factory $DistanceModelCopyWith(
          DistanceModel value, $Res Function(DistanceModel) then) =
      _$DistanceModelCopyWithImpl<$Res, DistanceModel>;
  @useResult
  $Res call({String rideId, double distance});
}

/// @nodoc
class _$DistanceModelCopyWithImpl<$Res, $Val extends DistanceModel>
    implements $DistanceModelCopyWith<$Res> {
  _$DistanceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rideId = null,
    Object? distance = null,
  }) {
    return _then(_value.copyWith(
      rideId: null == rideId
          ? _value.rideId
          : rideId // ignore: cast_nullable_to_non_nullable
              as String,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DistanceModelImplCopyWith<$Res>
    implements $DistanceModelCopyWith<$Res> {
  factory _$$DistanceModelImplCopyWith(
          _$DistanceModelImpl value, $Res Function(_$DistanceModelImpl) then) =
      __$$DistanceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String rideId, double distance});
}

/// @nodoc
class __$$DistanceModelImplCopyWithImpl<$Res>
    extends _$DistanceModelCopyWithImpl<$Res, _$DistanceModelImpl>
    implements _$$DistanceModelImplCopyWith<$Res> {
  __$$DistanceModelImplCopyWithImpl(
      _$DistanceModelImpl _value, $Res Function(_$DistanceModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rideId = null,
    Object? distance = null,
  }) {
    return _then(_$DistanceModelImpl(
      rideId: null == rideId
          ? _value.rideId
          : rideId // ignore: cast_nullable_to_non_nullable
              as String,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$DistanceModelImpl implements _DistanceModel {
  _$DistanceModelImpl({required this.rideId, required this.distance});

  @override
  final String rideId;
  @override
  final double distance;

  @override
  String toString() {
    return 'DistanceModel(rideId: $rideId, distance: $distance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DistanceModelImpl &&
            (identical(other.rideId, rideId) || other.rideId == rideId) &&
            (identical(other.distance, distance) ||
                other.distance == distance));
  }

  @override
  int get hashCode => Object.hash(runtimeType, rideId, distance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DistanceModelImplCopyWith<_$DistanceModelImpl> get copyWith =>
      __$$DistanceModelImplCopyWithImpl<_$DistanceModelImpl>(this, _$identity);
}

abstract class _DistanceModel implements DistanceModel {
  factory _DistanceModel(
      {required final String rideId,
      required final double distance}) = _$DistanceModelImpl;

  @override
  String get rideId;
  @override
  double get distance;
  @override
  @JsonKey(ignore: true)
  _$$DistanceModelImplCopyWith<_$DistanceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
