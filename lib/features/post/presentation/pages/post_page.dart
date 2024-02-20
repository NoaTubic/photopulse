// ignore_for_file: always_use_package_imports
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/constants/constants.dart';
import 'package:photopulse/common/constants/duration_constants.dart';
import 'package:photopulse/common/domain/router/navigation_extensions.dart';
import 'package:photopulse/common/domain/router/pages.dart';
import 'package:photopulse/common/domain/utils/base_state_extensions.dart';
import 'package:photopulse/common/domain/utils/form_key_extensions.dart';
import 'package:photopulse/common/presentation/animated_widgets/animated_column.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/base_dropdown.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_button.dart';
import 'package:photopulse/common/presentation/dialogs/photo_pulse_dialog.dart';
import 'package:photopulse/common/presentation/photo_pulse_app_bar.dart';
import 'package:photopulse/common/presentation/photo_pulse_scaffold.dart';
import 'package:photopulse/features/camera/domain/notifiers/camera_notifier.dart';
import 'package:photopulse/features/feed/presentation/widgets/feed_image.dart';
import 'package:photopulse/features/gallery/domain/notifier/gallery_notifier.dart';
import 'package:photopulse/features/location/domain/domain/notifiers/location_list_noifier.dart';
import 'package:photopulse/features/location/domain/domain/notifiers/location_notifier.dart';
import 'package:photopulse/features/location/domain/entities/post_location.dart';
import 'package:photopulse/features/navbar/domain/notifiers/nav_bar_visibility_provider.dart';
import 'package:photopulse/features/post/domain/entities/post.dart';
import 'package:photopulse/features/post/domain/notifiers/post_notifier.dart';
import 'package:photopulse/features/post/forms/post_form_config.dart';
import 'package:photopulse/features/post/presentation/widgets/hashtag_section.dart';
import 'package:photopulse/features/post/presentation/widgets/post_text_field.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:q_architecture/base_state_notifier.dart';

final isNextEnabled = StateProvider.autoDispose<bool>((_) => false);

final isPostChanged = StateProvider.autoDispose<bool>((_) => false);

class PostPage extends HookConsumerWidget {
  static const routeName = Pages.postPage;

  final Post? post;

  PostPage({super.key, this.post});

  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = ref.watch(cameraNotifierProvider).content ??
        ref.watch(galleryNotifierProvider).content;
    ref.listen(postNotifierProvider, (previous, next) {
      return switch (next) {
        BaseData() => post != null
            ? _finishPostEditing(context, ref)
            : _finishPostSubmitting(context, ref),
        _ => null,
      };
    });
    final postChanged = ref.watch(isPostChanged);
    ref.watch(locationNotifierProvider);

    return PopScope(
      onPopInvoked: (_) {
        _cancelPostForm(ref, context);

        false;
      },
      child: PhotoPulseScaffold(
        appBar: PhotoPulseAppBar.withBackNav(
          title:
              post != null ? S.current.update_post : S.current.create_new_post,
          onTap: () {
            _cancelPostForm(ref, context);
          },
        ),
        body: SingleChildScrollView(
          child: Center(
            child: AnimatedColumn(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FeedImage(
                  id: '1',
                  imageUrl: post != null ? post!.url : image?.path ?? '',
                ),
                const SizedBox(
                  height: AppSizes.normalSpacing,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.normalSpacing,
                    vertical: AppSizes.normalSpacing,
                  ),
                  child: FormBuilder(
                    key: formKey,
                    onChanged: () {
                      _updateIsPostChanged(ref, post);
                      _refreshNextEnabled(ref);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PostTextField(
                          name: PostFormConfig.titleKey,
                          label: S.current.post_title,
                          maxCharacter: Constants.postTitleMaximumCharacters,
                          textInputType: TextInputType.text,
                          isMandatory: false,
                          initialValue: post?.title,
                        ),
                        const SizedBox(
                          height: AppSizes.mediumSpacing,
                        ),
                        PostTextField(
                          name: PostFormConfig.captionKey,
                          label: S.current.post_caption,
                          maxCharacter: Constants.postCaptionMaximumCharacters,
                          textInputType: TextInputType.multiline,
                          isMandatory: true,
                          validators: [
                            PostFormConfig.required(),
                          ],
                          initialValue: post?.caption,
                        ),
                        const SizedBox(
                          height: AppSizes.mediumSpacing,
                        ),
                        const HashtagSection(),
                        const SizedBox(
                          height: AppSizes.mediumSpacing,
                        ),
                        BaseDropdown<PostLocation>(
                          onChanged: (postLocation) => ref
                              .read(locationListNotifierProvider.notifier)
                              .changeLocation(postLocation!),
                          values:
                              ref.watch(locationListNotifierProvider).locations,
                          hint: ref
                                  .watch(locationListNotifierProvider)
                                  .selectedLocation
                                  ?.name ??
                              '',
                        ),
                        const SizedBox(
                          height: AppSizes.mediumSpacing,
                        ),
                        PhotoPulseButton.primary(
                          onTap: () => formKey.submitForm((formMap) => ref
                              .read(postNotifierProvider.notifier)
                              .submitPostForm(
                                formMap: Map.from(formMap)
                                  ..addAll(
                                    {
                                      PostFormConfig.filePathKey: post != null
                                          ? post!.url
                                          : image?.path ?? '',
                                    },
                                  ),
                                post: post,
                                file: image,
                              )),
                          isEnabled: ref.watch(isNextEnabled) && postChanged,
                          isLoading: ref.read(postNotifierProvider).isLoading,
                          label: post != null
                              ? S.current.update_post
                              : S.current.create_post_button,
                        ),
                        const SizedBox(
                          height: AppSizes.normalSpacing,
                        ),
                        TextButton(
                          onPressed: () => _cancelPostForm(ref, context),
                          child: Text(
                            post != null ? S.current.cancel : S.current.retake,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _cancelPostForm(
    WidgetRef ref,
    BuildContext context,
  ) {
    if (formKey.isInitial() || !ref.read(isPostChanged)) {
      ref.pop();
    } else {
      PhotoPulseDialog.discardChanges(
        ref: ref,
        onConfirmPressed: () => ref.pop(),
        title: S.current.confirm_go_back_title,
        bodyText: S.current.changes_will_be_lost_body,
      ).show(context);
    }
  }

  void _finishPostEditing(
    BuildContext context,
    WidgetRef ref,
  ) {
    final timer = Timer(DurationConstants.createPostSubmitDuration, () {
      ref.pop();
    });
    PhotoPulseDialog.postSuccessful(ref.pop).show(context).whenComplete(() {
      timer.cancel();
      Navigator.of(context).pop();
    });
  }

  void _finishPostSubmitting(
    BuildContext context,
    WidgetRef ref,
  ) {
    final timer = Timer(DurationConstants.createPostSubmitDuration, () {
      ref.read(navBarVisibilityProvider.notifier).toggleNavBarVisibility();
      ref.pushNamed('/');
    });
    PhotoPulseDialog.postSuccessful(ref.pop).show(context).whenComplete(() {
      timer.cancel();
    });
  }

  void _refreshNextEnabled(WidgetRef ref) => WidgetsBinding.instance
      .addPostFrameCallback((_) => ref.read(isNextEnabled.notifier).state =
          formKey.currentState?.isValid ?? false);

  void _updateIsPostChanged(WidgetRef ref, Post? post) =>
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          final formState = formKey.currentState?..saveAndValidate();
          final formMap = formState?.value;
          ref.read(isPostChanged.notifier).state =
              formMap?[PostFormConfig.captionKey] != post?.caption ||
                  formMap?[PostFormConfig.titleKey] != post?.title;
        },
      );
}
