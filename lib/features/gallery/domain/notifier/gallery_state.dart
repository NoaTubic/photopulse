import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:q_architecture/q_architecture.dart';

part 'gallery_state.freezed.dart';

@freezed
class GalleryState with _$GalleryState {
  const factory GalleryState({
    File? content,
    Failure? failure,
    required bool permissionRequested,
  }) = _GalleryState;

  factory GalleryState.initial() => const GalleryState(
        permissionRequested: false,
      );
}
