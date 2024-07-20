// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'way_point_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WayPointModel {
  GeoPoint get start => throw _privateConstructorUsedError;
  GeoPoint get destination => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WayPointModelCopyWith<WayPointModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WayPointModelCopyWith<$Res> {
  factory $WayPointModelCopyWith(
          WayPointModel value, $Res Function(WayPointModel) then) =
      _$WayPointModelCopyWithImpl<$Res, WayPointModel>;
  @useResult
  $Res call({GeoPoint start, GeoPoint destination, String id, int index});
}

/// @nodoc
class _$WayPointModelCopyWithImpl<$Res, $Val extends WayPointModel>
    implements $WayPointModelCopyWith<$Res> {
  _$WayPointModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? destination = null,
    Object? id = null,
    Object? index = null,
  }) {
    return _then(_value.copyWith(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WayPointModelImplCopyWith<$Res>
    implements $WayPointModelCopyWith<$Res> {
  factory _$$WayPointModelImplCopyWith(
          _$WayPointModelImpl value, $Res Function(_$WayPointModelImpl) then) =
      __$$WayPointModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GeoPoint start, GeoPoint destination, String id, int index});
}

/// @nodoc
class __$$WayPointModelImplCopyWithImpl<$Res>
    extends _$WayPointModelCopyWithImpl<$Res, _$WayPointModelImpl>
    implements _$$WayPointModelImplCopyWith<$Res> {
  __$$WayPointModelImplCopyWithImpl(
      _$WayPointModelImpl _value, $Res Function(_$WayPointModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? destination = null,
    Object? id = null,
    Object? index = null,
  }) {
    return _then(_$WayPointModelImpl(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$WayPointModelImpl implements _WayPointModel {
  _$WayPointModelImpl(
      {required this.start,
      required this.destination,
      required this.id,
      required this.index});

  @override
  final GeoPoint start;
  @override
  final GeoPoint destination;
  @override
  final String id;
  @override
  final int index;

  @override
  String toString() {
    return 'WayPointModel(start: $start, destination: $destination, id: $id, index: $index)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WayPointModelImpl &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, start, destination, id, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WayPointModelImplCopyWith<_$WayPointModelImpl> get copyWith =>
      __$$WayPointModelImplCopyWithImpl<_$WayPointModelImpl>(this, _$identity);
}

abstract class _WayPointModel implements WayPointModel {
  factory _WayPointModel(
      {required final GeoPoint start,
      required final GeoPoint destination,
      required final String id,
      required final int index}) = _$WayPointModelImpl;

  @override
  GeoPoint get start;
  @override
  GeoPoint get destination;
  @override
  String get id;
  @override
  int get index;
  @override
  @JsonKey(ignore: true)
  _$$WayPointModelImplCopyWith<_$WayPointModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
