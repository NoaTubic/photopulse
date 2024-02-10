import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photopulse/features/auth/domain/entities/user.dart';

part 'filters_state.freezed.dart';

@freezed
class FiltersState with _$FiltersState {
  const factory FiltersState({
    required List<PhotoPulseUser> users,
    PhotoPulseUser? selectedUser,
    List<String>? hashtags,
    double? minImageSizeMb,
    double? maxImageSizeMb,
    DateTimeRange? dateTimeRange,
    String? authorId,
  }) = _FiltersState;

  factory FiltersState.initial() => const FiltersState(
        users: [],
      );
}
