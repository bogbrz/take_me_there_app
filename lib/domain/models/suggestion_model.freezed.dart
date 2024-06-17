// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'suggestion_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SuggestionModel {
  String get streetName => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SuggestionModelCopyWith<SuggestionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SuggestionModelCopyWith<$Res> {
  factory $SuggestionModelCopyWith(
          SuggestionModel value, $Res Function(SuggestionModel) then) =
      _$SuggestionModelCopyWithImpl<$Res, SuggestionModel>;
  @useResult
  $Res call({String streetName});
}

/// @nodoc
class _$SuggestionModelCopyWithImpl<$Res, $Val extends SuggestionModel>
    implements $SuggestionModelCopyWith<$Res> {
  _$SuggestionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? streetName = null,
  }) {
    return _then(_value.copyWith(
      streetName: null == streetName
          ? _value.streetName
          : streetName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SuggestionModelImplCopyWith<$Res>
    implements $SuggestionModelCopyWith<$Res> {
  factory _$$SuggestionModelImplCopyWith(_$SuggestionModelImpl value,
          $Res Function(_$SuggestionModelImpl) then) =
      __$$SuggestionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String streetName});
}

/// @nodoc
class __$$SuggestionModelImplCopyWithImpl<$Res>
    extends _$SuggestionModelCopyWithImpl<$Res, _$SuggestionModelImpl>
    implements _$$SuggestionModelImplCopyWith<$Res> {
  __$$SuggestionModelImplCopyWithImpl(
      _$SuggestionModelImpl _value, $Res Function(_$SuggestionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? streetName = null,
  }) {
    return _then(_$SuggestionModelImpl(
      streetName: null == streetName
          ? _value.streetName
          : streetName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SuggestionModelImpl implements _SuggestionModel {
  _$SuggestionModelImpl({required this.streetName});

  @override
  final String streetName;

  @override
  String toString() {
    return 'SuggestionModel(streetName: $streetName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuggestionModelImpl &&
            (identical(other.streetName, streetName) ||
                other.streetName == streetName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, streetName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuggestionModelImplCopyWith<_$SuggestionModelImpl> get copyWith =>
      __$$SuggestionModelImplCopyWithImpl<_$SuggestionModelImpl>(
          this, _$identity);
}

abstract class _SuggestionModel implements SuggestionModel {
  factory _SuggestionModel({required final String streetName}) =
      _$SuggestionModelImpl;

  @override
  String get streetName;
  @override
  @JsonKey(ignore: true)
  _$$SuggestionModelImplCopyWith<_$SuggestionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
