import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/features/auth/data/repository/users_repository.dart';
import 'package:photopulse/features/auth/domain/entities/user.dart';
import 'package:photopulse/features/feed/domain/notifiers/filters_state.dart';
import 'package:q_architecture/q_architecture.dart';

final filtersNotifierProvider =
    StateNotifierProvider<FiltersNotifier, FiltersState>(
  (ref) => FiltersNotifier(
    ref,
    ref.watch(usersRepositoryProvider),
  )..getUsers(),
);

class FiltersNotifier extends SimpleStateNotifier<FiltersState> {
  final UsersRepository _usersRepository;
  FiltersNotifier(Ref ref, this._usersRepository)
      : super(ref, FiltersState.initial());

  Future<void> getUsers() async {
    final users = await _usersRepository.getUsers();
    users.fold(
      (failure) => null,
      (users) => state = state.copyWith(users: users),
    );
  }

  void changeUser(PhotoPulseUser? user) {
    state = state.copyWith(selectedUser: user, authorId: user?.id);
  }

  void addHashtag(String hashtag) {
    state = state.copyWith(
      hashtags: [...state.hashtags ?? [], hashtag],
    );
  }

  void removeHashtag(String hashtag) {
    state = state.copyWith(
      hashtags: state.hashtags?.where((h) => h != hashtag).toList(),
    );
  }

  void toggleDateDescending() {
    state = state.copyWith(dateDescending: !state.dateDescending);
  }

  void toggleSizeDescending() {
    state = state.copyWith(sizeDescending: !state.sizeDescending);
  }

  void addAuthorId(String? authorId) {
    state = state.copyWith(authorId: authorId);
  }

  void removeAuthorId() {
    state = state.copyWith(authorId: null);
  }

  void clearFilters() {
    state = FiltersState.initial();
  }
}
