// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gallery_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GalleryState {
  File? get content => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  bool get permissionRequested => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GalleryStateCopyWith<GalleryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GalleryStateCopyWith<$Res> {
  factory $GalleryStateCopyWith(
          GalleryState value, $Res Function(GalleryState) then) =
      _$GalleryStateCopyWithImpl<$Res, GalleryState>;
  @useResult
  $Res call({File? content, Failure? failure, bool permissionRequested});
}

/// @nodoc
class _$GalleryStateCopyWithImpl<$Res, $Val extends GalleryState>
    implements $GalleryStateCopyWith<$Res> {
  _$GalleryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = freezed,
    Object? failure = freezed,
    Object? permissionRequested = null,
  }) {
    return _then(_value.copyWith(
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as File?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      permissionRequested: null == permissionRequested
          ? _value.permissionRequested
          : permissionRequested // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GalleryStateImplCopyWith<$Res>
    implements $GalleryStateCopyWith<$Res> {
  factory _$$GalleryStateImplCopyWith(
          _$GalleryStateImpl value, $Res Function(_$GalleryStateImpl) then) =
      __$$GalleryStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({File? content, Failure? failure, bool permissionRequested});
}

/// @nodoc
class __$$GalleryStateImplCopyWithImpl<$Res>
    extends _$GalleryStateCopyWithImpl<$Res, _$GalleryStateImpl>
    implements _$$GalleryStateImplCopyWith<$Res> {
  __$$GalleryStateImplCopyWithImpl(
      _$GalleryStateImpl _value, $Res Function(_$GalleryStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = freezed,
    Object? failure = freezed,
    Object? permissionRequested = null,
  }) {
    return _then(_$GalleryStateImpl(
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as File?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      permissionRequested: null == permissionRequested
          ? _value.permissionRequested
          : permissionRequested // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$GalleryStateImpl implements _GalleryState {
  const _$GalleryStateImpl(
      {this.content, this.failure, required this.permissionRequested});

  @override
  final File? content;
  @override
  final Failure? failure;
  @override
  final bool permissionRequested;

  @override
  String toString() {
    return 'GalleryState(content: $content, failure: $failure, permissionRequested: $permissionRequested)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GalleryStateImpl &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.permissionRequested, permissionRequested) ||
                other.permissionRequested == permissionRequested));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, content, failure, permissionRequested);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GalleryStateImplCopyWith<_$GalleryStateImpl> get copyWith =>
      __$$GalleryStateImplCopyWithImpl<_$GalleryStateImpl>(this, _$identity);
}

abstract class _GalleryState implements GalleryState {
  const factory _GalleryState(
      {final File? content,
      final Failure? failure,
      required final bool permissionRequested}) = _$GalleryStateImpl;

  @override
  File? get content;
  @override
  Failure? get failure;
  @override
  bool get permissionRequested;
  @override
  @JsonKey(ignore: true)
  _$$GalleryStateImplCopyWith<_$GalleryStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
