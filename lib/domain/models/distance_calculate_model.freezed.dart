// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'distance_calculate_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CalculateModel {
  String get rideId => throw _privateConstructorUsedError;
  LatLng get coordinates => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CalculateModelCopyWith<CalculateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalculateModelCopyWith<$Res> {
  factory $CalculateModelCopyWith(
          CalculateModel value, $Res Function(CalculateModel) then) =
      _$CalculateModelCopyWithImpl<$Res, CalculateModel>;
  @useResult
  $Res call({String rideId, LatLng coordinates});
}

/// @nodoc
class _$CalculateModelCopyWithImpl<$Res, $Val extends CalculateModel>
    implements $CalculateModelCopyWith<$Res> {
  _$CalculateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rideId = null,
    Object? coordinates = null,
  }) {
    return _then(_value.copyWith(
      rideId: null == rideId
          ? _value.rideId
          : rideId // ignore: cast_nullable_to_non_nullable
              as String,
      coordinates: null == coordinates
          ? _value.coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as LatLng,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CalculateModelImplCopyWith<$Res>
    implements $CalculateModelCopyWith<$Res> {
  factory _$$CalculateModelImplCopyWith(_$CalculateModelImpl value,
          $Res Function(_$CalculateModelImpl) then) =
      __$$CalculateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String rideId, LatLng coordinates});
}

/// @nodoc
class __$$CalculateModelImplCopyWithImpl<$Res>
    extends _$CalculateModelCopyWithImpl<$Res, _$CalculateModelImpl>
    implements _$$CalculateModelImplCopyWith<$Res> {
  __$$CalculateModelImplCopyWithImpl(
      _$CalculateModelImpl _value, $Res Function(_$CalculateModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rideId = null,
    Object? coordinates = null,
  }) {
    return _then(_$CalculateModelImpl(
      rideId: null == rideId
          ? _value.rideId
          : rideId // ignore: cast_nullable_to_non_nullable
              as String,
      coordinates: null == coordinates
          ? _value.coordinates
          : coordinates // ignore: cast_nullable_to_non_nullable
              as LatLng,
    ));
  }
}

/// @nodoc

class _$CalculateModelImpl implements _CalculateModel {
  _$CalculateModelImpl({required this.rideId, required this.coordinates});

  @override
  final String rideId;
  @override
  final LatLng coordinates;

  @override
  String toString() {
    return 'CalculateModel(rideId: $rideId, coordinates: $coordinates)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalculateModelImpl &&
            (identical(other.rideId, rideId) || other.rideId == rideId) &&
            (identical(other.coordinates, coordinates) ||
                other.coordinates == coordinates));
  }

  @override
  int get hashCode => Object.hash(runtimeType, rideId, coordinates);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CalculateModelImplCopyWith<_$CalculateModelImpl> get copyWith =>
      __$$CalculateModelImplCopyWithImpl<_$CalculateModelImpl>(
          this, _$identity);
}

abstract class _CalculateModel implements CalculateModel {
  factory _CalculateModel(
      {required final String rideId,
      required final LatLng coordinates}) = _$CalculateModelImpl;

  @override
  String get rideId;
  @override
  LatLng get coordinates;
  @override
  @JsonKey(ignore: true)
  _$$CalculateModelImplCopyWith<_$CalculateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
