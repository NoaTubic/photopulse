// ignore_for_file: always_use_package_imports

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/constants/constants.dart';
import 'package:photopulse/common/constants/duration_constants.dart';
import 'package:photopulse/common/domain/router/pages.dart';
import 'package:photopulse/common/domain/utils/form_key_extensions.dart';
import 'package:photopulse/common/presentation/animated_widgets/animated_column.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_button.dart';
import 'package:photopulse/common/presentation/buttons/photo_pulse_icon_button.dart';
import 'package:photopulse/common/presentation/dialogs/photo_pulse_dialog.dart';
import 'package:photopulse/common/presentation/photo_pulse_app_bar.dart';
import 'package:photopulse/common/presentation/photo_pulse_scaffold.dart';
import 'package:photopulse/features/camera/domain/notifiers/camera_notifier.dart';
import 'package:photopulse/features/feed/presentation/widgets/feed_image.dart';
import 'package:photopulse/features/gallery/domain/notifier/gallery_notifier.dart';
import 'package:photopulse/features/post/domain/entities/post.dart';
import 'package:photopulse/features/post/domain/notifiers/hashtag_notifer.dart';
import 'package:photopulse/features/post/domain/notifiers/post_notifier.dart';
import 'package:photopulse/features/post/forms/post_form_config.dart';
import 'package:photopulse/features/post/presentation/widgets/post_text_field.dart';
import 'package:photopulse/theme/app_colors.dart';

final isNextEnabled = StateProvider.autoDispose<bool>((_) => false);

final isPostChanged = StateProvider.autoDispose<bool>((_) => false);

final formKey = GlobalKey<FormBuilderState>();

class PostPage extends HookConsumerWidget {
  static const routeName = Pages.postPage;

  final Post? post;

  const PostPage({super.key, this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = ref.watch(cameraNotifierProvider).content ??
        ref.watch(galleryNotifierProvider).content;
    // ref.listen(postNotifierProvider, (previous, next) {
    //   next.maybeMap(
    //     data: (data) {
    //       if (data.data == PostStatus.created) {
    //         _finishPostSubmitting(context, ref, isPoa);
    //       } else {
    //         Navigator.of(context).pop();
    //       }
    //     },
    //     orElse: () {},
    //   );
    // });
    final postChanged = ref.watch(isPostChanged);
    final controller1 = useTextEditingController();
    final controller2 = useTextEditingController();
    final controller3 = useTextEditingController();

    return PopScope(
      // onPopInvoked: () async {
      //   // return ref.read(postNotifierProvider).maybeWhen(
      //   //       loading: () => false,
      //   //       orElse: () => true,
      //   //     );
      // },
      child: PhotoPulseScaffold(
        appBar: PhotoPulseAppBar.withBackNav(
          title: post != null ? 'Update post' : 'Create new post',
          onTap: () {
            _cancelPostForm(ref, context);
          },
        ),
        // padding: EdgeInsets.zero,
        body: SingleChildScrollView(
          child: Center(
            child: AnimatedColumn(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FeedImage(
                  id: 1,
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
                    // onChanged: () {
                    //   _updateIsPostChanged(ref, post);
                    //   _refreshNextEnabled(ref);
                    // },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PostTextField(
                          controller: controller1,
                          name: PostFormConfig.titleKey,
                          label: 'Title',
                          maxCharacter: Constants.postTitleMaximumCharacters,
                          textInputType: TextInputType.text,
                          isMandatory: false,
                          initialValue: post?.title,
                        ),
                        const SizedBox(
                          height: AppSizes.mediumSpacing,
                        ),
                        PostTextField(
                          controller: controller2,
                          name: PostFormConfig.captionKey,
                          label: 'Caption',
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
                        PhotoPulseButton.primary(
                          onTap: () => formKey.submitForm(
                            (formMap) => ref
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
                                ),
                          ),
                          // isEnabled: ref.watch(isNextEnabled) && postChanged,
                          label: 'Create post',
                        ),
                        const SizedBox(
                          height: AppSizes.normalSpacing,
                        ),
                        TextButton(
                          onPressed: () => _cancelPostForm(ref, context),
                          child: Text(
                            post != null ? 'Cancel' : 'Retake',
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
      Navigator.of(context).pop();
    } else {
      PhotoPulseDialog.discardChanges(
        ref: ref,
        onConfirmPressed: () => Navigator.of(context).pop(),
        title: 'Are you sure you want to go back?',
        bodyText: 'If you go back now, the changes you made will be lost.',
      ).show(context);
    }
  }

  void _finishPostSubmitting(
    BuildContext context,
    WidgetRef ref,
  ) {
    final timer = Timer(DurationConstants.createPostSubmitDuration, () {});
    PhotoPulseDialog.postSuccessful()
        .show(context)
        .whenComplete(() => timer.cancel());
  }

  void _refreshNextEnabled(WidgetRef ref) => WidgetsBinding.instance
      .addPostFrameCallback((_) => ref.read(isNextEnabled.notifier).state =
          formKey.currentState?.isValid ?? false);

  void _updateIsPostChanged(WidgetRef ref, Post? post) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final formState = formKey.currentState?..saveAndValidate();
        final formMap = formState?.value;
        ref.read(isPostChanged.notifier).state =
            formMap?[PostFormConfig.captionKey] != post?.caption ||
                formMap?[PostFormConfig.titleKey] != post?.title;
      });
}

class HashtagSection extends HookConsumerWidget {
  const HashtagSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hashtagController = TextEditingController();
    final hashtagNotifier = ref.read(hashtagNotifierProvider.notifier);
    final hashtags = ref.watch(hashtagNotifierProvider);

    return Column(
      children: [
        PostTextField(
          controller: hashtagController,
          name: 'hashtags',
          label: 'Hashtags',
          maxCharacter: Constants.hashtagMaximumCharacters,
          isMandatory: false,
          textInputType: TextInputType.text,
          action: Container(
            width: 64,
            height: 22,
            padding: const EdgeInsets.all(
              AppSizes.smallSpacing,
            ),
            child: FilledButton(
              onPressed: () {
                log(hashtagController.value.text);
                hashtagNotifier.addHashtag(hashtagController.value.text);
                // hashtagController.clear();
              },
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.smallSpacing,
                ),
                backgroundColor: AppColors.black,
                side: BorderSide(
                  color: AppColors.black,
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
              child: Icon(
                Icons.add_rounded,
                color: AppColors.white,
              ),
            ),
          ),
        ),
        if (hashtags.isNotEmpty) ...[
          Wrap(
            spacing: AppSizes.smallSpacing,
            runSpacing: AppSizes.smallSpacing,
            children: hashtags
                .map(
                  (hashtag) => Chip(
                    label: Text(hashtag),
                    onDeleted: () => hashtagNotifier.removeHashtag(hashtag),
                  ),
                )
                .toList(),
          ),
        ]
      ],
    );
  }
}