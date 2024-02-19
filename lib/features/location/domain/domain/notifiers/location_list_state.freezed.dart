// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LocationListState {
  PostLocation? get selectedLocation => throw _privateConstructorUsedError;
  List<PostLocation> get locations => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LocationListStateCopyWith<LocationListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationListStateCopyWith<$Res> {
  factory $LocationListStateCopyWith(
          LocationListState value, $Res Function(LocationListState) then) =
      _$LocationListStateCopyWithImpl<$Res, LocationListState>;
  @useResult
  $Res call({PostLocation? selectedLocation, List<PostLocation> locations});
}

/// @nodoc
class _$LocationListStateCopyWithImpl<$Res, $Val extends LocationListState>
    implements $LocationListStateCopyWith<$Res> {
  _$LocationListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedLocation = freezed,
    Object? locations = null,
  }) {
    return _then(_value.copyWith(
      selectedLocation: freezed == selectedLocation
          ? _value.selectedLocation
          : selectedLocation // ignore: cast_nullable_to_non_nullable
              as PostLocation?,
      locations: null == locations
          ? _value.locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<PostLocation>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationListStateImplCopyWith<$Res>
    implements $LocationListStateCopyWith<$Res> {
  factory _$$LocationListStateImplCopyWith(_$LocationListStateImpl value,
          $Res Function(_$LocationListStateImpl) then) =
      __$$LocationListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PostLocation? selectedLocation, List<PostLocation> locations});
}

/// @nodoc
class __$$LocationListStateImplCopyWithImpl<$Res>
    extends _$LocationListStateCopyWithImpl<$Res, _$LocationListStateImpl>
    implements _$$LocationListStateImplCopyWith<$Res> {
  __$$LocationListStateImplCopyWithImpl(_$LocationListStateImpl _value,
      $Res Function(_$LocationListStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedLocation = freezed,
    Object? locations = null,
  }) {
    return _then(_$LocationListStateImpl(
      selectedLocation: freezed == selectedLocation
          ? _value.selectedLocation
          : selectedLocation // ignore: cast_nullable_to_non_nullable
              as PostLocation?,
      locations: null == locations
          ? _value._locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<PostLocation>,
    ));
  }
}

/// @nodoc

class _$LocationListStateImpl implements _LocationListState {
  const _$LocationListStateImpl(
      {this.selectedLocation, required final List<PostLocation> locations})
      : _locations = locations;

  @override
  final PostLocation? selectedLocation;
  final List<PostLocation> _locations;
  @override
  List<PostLocation> get locations {
    if (_locations is EqualUnmodifiableListView) return _locations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_locations);
  }

  @override
  String toString() {
    return 'LocationListState(selectedLocation: $selectedLocation, locations: $locations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationListStateImpl &&
            (identical(other.selectedLocation, selectedLocation) ||
                other.selectedLocation == selectedLocation) &&
            const DeepCollectionEquality()
                .equals(other._locations, _locations));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedLocation,
      const DeepCollectionEquality().hash(_locations));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationListStateImplCopyWith<_$LocationListStateImpl> get copyWith =>
      __$$LocationListStateImplCopyWithImpl<_$LocationListStateImpl>(
          this, _$identity);
}

abstract class _LocationListState implements LocationListState {
  const factory _LocationListState(
      {final PostLocation? selectedLocation,
      required final List<PostLocation> locations}) = _$LocationListStateImpl;

  @override
  PostLocation? get selectedLocation;
  @override
  List<PostLocation> get locations;
  @override
  @JsonKey(ignore: true)
  _$$LocationListStateImplCopyWith<_$LocationListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
