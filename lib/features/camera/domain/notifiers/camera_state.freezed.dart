// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'camera_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CameraState {
  CameraController? get controller => throw _privateConstructorUsedError;
  bool get isControllerInitialized => throw _privateConstructorUsedError;
  List<CameraDescription> get cameras => throw _privateConstructorUsedError;
  bool get isSelfie => throw _privateConstructorUsedError;
  bool get isFlashOn => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  bool get permissionRequested => throw _privateConstructorUsedError;
  File? get content => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CameraStateCopyWith<CameraState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CameraStateCopyWith<$Res> {
  factory $CameraStateCopyWith(
          CameraState value, $Res Function(CameraState) then) =
      _$CameraStateCopyWithImpl<$Res, CameraState>;
  @useResult
  $Res call(
      {CameraController? controller,
      bool isControllerInitialized,
      List<CameraDescription> cameras,
      bool isSelfie,
      bool isFlashOn,
      Failure? failure,
      bool permissionRequested,
      File? content});
}

/// @nodoc
class _$CameraStateCopyWithImpl<$Res, $Val extends CameraState>
    implements $CameraStateCopyWith<$Res> {
  _$CameraStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? controller = freezed,
    Object? isControllerInitialized = null,
    Object? cameras = null,
    Object? isSelfie = null,
    Object? isFlashOn = null,
    Object? failure = freezed,
    Object? permissionRequested = null,
    Object? content = freezed,
  }) {
    return _then(_value.copyWith(
      controller: freezed == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as CameraController?,
      isControllerInitialized: null == isControllerInitialized
          ? _value.isControllerInitialized
          : isControllerInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      cameras: null == cameras
          ? _value.cameras
          : cameras // ignore: cast_nullable_to_non_nullable
              as List<CameraDescription>,
      isSelfie: null == isSelfie
          ? _value.isSelfie
          : isSelfie // ignore: cast_nullable_to_non_nullable
              as bool,
      isFlashOn: null == isFlashOn
          ? _value.isFlashOn
          : isFlashOn // ignore: cast_nullable_to_non_nullable
              as bool,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      permissionRequested: null == permissionRequested
          ? _value.permissionRequested
          : permissionRequested // ignore: cast_nullable_to_non_nullable
              as bool,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as File?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CameraStateImplCopyWith<$Res>
    implements $CameraStateCopyWith<$Res> {
  factory _$$CameraStateImplCopyWith(
          _$CameraStateImpl value, $Res Function(_$CameraStateImpl) then) =
      __$$CameraStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CameraController? controller,
      bool isControllerInitialized,
      List<CameraDescription> cameras,
      bool isSelfie,
      bool isFlashOn,
      Failure? failure,
      bool permissionRequested,
      File? content});
}

/// @nodoc
class __$$CameraStateImplCopyWithImpl<$Res>
    extends _$CameraStateCopyWithImpl<$Res, _$CameraStateImpl>
    implements _$$CameraStateImplCopyWith<$Res> {
  __$$CameraStateImplCopyWithImpl(
      _$CameraStateImpl _value, $Res Function(_$CameraStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? controller = freezed,
    Object? isControllerInitialized = null,
    Object? cameras = null,
    Object? isSelfie = null,
    Object? isFlashOn = null,
    Object? failure = freezed,
    Object? permissionRequested = null,
    Object? content = freezed,
  }) {
    return _then(_$CameraStateImpl(
      controller: freezed == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as CameraController?,
      isControllerInitialized: null == isControllerInitialized
          ? _value.isControllerInitialized
          : isControllerInitialized // ignore: cast_nullable_to_non_nullable
              as bool,
      cameras: null == cameras
          ? _value._cameras
          : cameras // ignore: cast_nullable_to_non_nullable
              as List<CameraDescription>,
      isSelfie: null == isSelfie
          ? _value.isSelfie
          : isSelfie // ignore: cast_nullable_to_non_nullable
              as bool,
      isFlashOn: null == isFlashOn
          ? _value.isFlashOn
          : isFlashOn // ignore: cast_nullable_to_non_nullable
              as bool,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      permissionRequested: null == permissionRequested
          ? _value.permissionRequested
          : permissionRequested // ignore: cast_nullable_to_non_nullable
              as bool,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc

class _$CameraStateImpl implements _CameraState {
  const _$CameraStateImpl(
      {this.controller,
      required this.isControllerInitialized,
      required final List<CameraDescription> cameras,
      required this.isSelfie,
      required this.isFlashOn,
      this.failure,
      required this.permissionRequested,
      this.content})
      : _cameras = cameras;

  @override
  final CameraController? controller;
  @override
  final bool isControllerInitialized;
  final List<CameraDescription> _cameras;
  @override
  List<CameraDescription> get cameras {
    if (_cameras is EqualUnmodifiableListView) return _cameras;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cameras);
  }

  @override
  final bool isSelfie;
  @override
  final bool isFlashOn;
  @override
  final Failure? failure;
  @override
  final bool permissionRequested;
  @override
  final File? content;

  @override
  String toString() {
    return 'CameraState(controller: $controller, isControllerInitialized: $isControllerInitialized, cameras: $cameras, isSelfie: $isSelfie, isFlashOn: $isFlashOn, failure: $failure, permissionRequested: $permissionRequested, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CameraStateImpl &&
            (identical(other.controller, controller) ||
                other.controller == controller) &&
            (identical(
                    other.isControllerInitialized, isControllerInitialized) ||
                other.isControllerInitialized == isControllerInitialized) &&
            const DeepCollectionEquality().equals(other._cameras, _cameras) &&
            (identical(other.isSelfie, isSelfie) ||
                other.isSelfie == isSelfie) &&
            (identical(other.isFlashOn, isFlashOn) ||
                other.isFlashOn == isFlashOn) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.permissionRequested, permissionRequested) ||
                other.permissionRequested == permissionRequested) &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      controller,
      isControllerInitialized,
      const DeepCollectionEquality().hash(_cameras),
      isSelfie,
      isFlashOn,
      failure,
      permissionRequested,
      content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CameraStateImplCopyWith<_$CameraStateImpl> get copyWith =>
      __$$CameraStateImplCopyWithImpl<_$CameraStateImpl>(this, _$identity);
}

abstract class _CameraState implements CameraState {
  const factory _CameraState(
      {final CameraController? controller,
      required final bool isControllerInitialized,
      required final List<CameraDescription> cameras,
      required final bool isSelfie,
      required final bool isFlashOn,
      final Failure? failure,
      required final bool permissionRequested,
      final File? content}) = _$CameraStateImpl;

  @override
  CameraController? get controller;
  @override
  bool get isControllerInitialized;
  @override
  List<CameraDescription> get cameras;
  @override
  bool get isSelfie;
  @override
  bool get isFlashOn;
  @override
  Failure? get failure;
  @override
  bool get permissionRequested;
  @override
  File? get content;
  @override
  @JsonKey(ignore: true)
  _$$CameraStateImplCopyWith<_$CameraStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
