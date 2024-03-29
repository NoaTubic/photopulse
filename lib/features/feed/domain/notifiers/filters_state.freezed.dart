// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filters_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FiltersState {
  List<PhotoPulseUser> get users => throw _privateConstructorUsedError;
  PhotoPulseUser? get selectedUser => throw _privateConstructorUsedError;
  List<String>? get hashtags => throw _privateConstructorUsedError;
  bool get dateDescending => throw _privateConstructorUsedError;
  bool get sizeDescending => throw _privateConstructorUsedError;
  String? get authorId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FiltersStateCopyWith<FiltersState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FiltersStateCopyWith<$Res> {
  factory $FiltersStateCopyWith(
          FiltersState value, $Res Function(FiltersState) then) =
      _$FiltersStateCopyWithImpl<$Res, FiltersState>;
  @useResult
  $Res call(
      {List<PhotoPulseUser> users,
      PhotoPulseUser? selectedUser,
      List<String>? hashtags,
      bool dateDescending,
      bool sizeDescending,
      String? authorId});
}

/// @nodoc
class _$FiltersStateCopyWithImpl<$Res, $Val extends FiltersState>
    implements $FiltersStateCopyWith<$Res> {
  _$FiltersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = null,
    Object? selectedUser = freezed,
    Object? hashtags = freezed,
    Object? dateDescending = null,
    Object? sizeDescending = null,
    Object? authorId = freezed,
  }) {
    return _then(_value.copyWith(
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<PhotoPulseUser>,
      selectedUser: freezed == selectedUser
          ? _value.selectedUser
          : selectedUser // ignore: cast_nullable_to_non_nullable
              as PhotoPulseUser?,
      hashtags: freezed == hashtags
          ? _value.hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      dateDescending: null == dateDescending
          ? _value.dateDescending
          : dateDescending // ignore: cast_nullable_to_non_nullable
              as bool,
      sizeDescending: null == sizeDescending
          ? _value.sizeDescending
          : sizeDescending // ignore: cast_nullable_to_non_nullable
              as bool,
      authorId: freezed == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FiltersStateImplCopyWith<$Res>
    implements $FiltersStateCopyWith<$Res> {
  factory _$$FiltersStateImplCopyWith(
          _$FiltersStateImpl value, $Res Function(_$FiltersStateImpl) then) =
      __$$FiltersStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<PhotoPulseUser> users,
      PhotoPulseUser? selectedUser,
      List<String>? hashtags,
      bool dateDescending,
      bool sizeDescending,
      String? authorId});
}

/// @nodoc
class __$$FiltersStateImplCopyWithImpl<$Res>
    extends _$FiltersStateCopyWithImpl<$Res, _$FiltersStateImpl>
    implements _$$FiltersStateImplCopyWith<$Res> {
  __$$FiltersStateImplCopyWithImpl(
      _$FiltersStateImpl _value, $Res Function(_$FiltersStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = null,
    Object? selectedUser = freezed,
    Object? hashtags = freezed,
    Object? dateDescending = null,
    Object? sizeDescending = null,
    Object? authorId = freezed,
  }) {
    return _then(_$FiltersStateImpl(
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<PhotoPulseUser>,
      selectedUser: freezed == selectedUser
          ? _value.selectedUser
          : selectedUser // ignore: cast_nullable_to_non_nullable
              as PhotoPulseUser?,
      hashtags: freezed == hashtags
          ? _value._hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      dateDescending: null == dateDescending
          ? _value.dateDescending
          : dateDescending // ignore: cast_nullable_to_non_nullable
              as bool,
      sizeDescending: null == sizeDescending
          ? _value.sizeDescending
          : sizeDescending // ignore: cast_nullable_to_non_nullable
              as bool,
      authorId: freezed == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$FiltersStateImpl implements _FiltersState {
  const _$FiltersStateImpl(
      {required final List<PhotoPulseUser> users,
      this.selectedUser,
      final List<String>? hashtags,
      required this.dateDescending,
      required this.sizeDescending,
      this.authorId})
      : _users = users,
        _hashtags = hashtags;

  final List<PhotoPulseUser> _users;
  @override
  List<PhotoPulseUser> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  final PhotoPulseUser? selectedUser;
  final List<String>? _hashtags;
  @override
  List<String>? get hashtags {
    final value = _hashtags;
    if (value == null) return null;
    if (_hashtags is EqualUnmodifiableListView) return _hashtags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool dateDescending;
  @override
  final bool sizeDescending;
  @override
  final String? authorId;

  @override
  String toString() {
    return 'FiltersState(users: $users, selectedUser: $selectedUser, hashtags: $hashtags, dateDescending: $dateDescending, sizeDescending: $sizeDescending, authorId: $authorId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FiltersStateImpl &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(other.selectedUser, selectedUser) ||
                other.selectedUser == selectedUser) &&
            const DeepCollectionEquality().equals(other._hashtags, _hashtags) &&
            (identical(other.dateDescending, dateDescending) ||
                other.dateDescending == dateDescending) &&
            (identical(other.sizeDescending, sizeDescending) ||
                other.sizeDescending == sizeDescending) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_users),
      selectedUser,
      const DeepCollectionEquality().hash(_hashtags),
      dateDescending,
      sizeDescending,
      authorId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FiltersStateImplCopyWith<_$FiltersStateImpl> get copyWith =>
      __$$FiltersStateImplCopyWithImpl<_$FiltersStateImpl>(this, _$identity);
}

abstract class _FiltersState implements FiltersState {
  const factory _FiltersState(
      {required final List<PhotoPulseUser> users,
      final PhotoPulseUser? selectedUser,
      final List<String>? hashtags,
      required final bool dateDescending,
      required final bool sizeDescending,
      final String? authorId}) = _$FiltersStateImpl;

  @override
  List<PhotoPulseUser> get users;
  @override
  PhotoPulseUser? get selectedUser;
  @override
  List<String>? get hashtags;
  @override
  bool get dateDescending;
  @override
  bool get sizeDescending;
  @override
  String? get authorId;
  @override
  @JsonKey(ignore: true)
  _$$FiltersStateImplCopyWith<_$FiltersStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
