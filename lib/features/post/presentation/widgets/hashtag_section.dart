import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/constants/constants.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/features/post/domain/notifiers/hashtag_notifer.dart';
import 'package:photopulse/features/post/presentation/widgets/post_text_field.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:photopulse/theme/app_colors.dart';

class HashtagSection extends HookConsumerWidget {
  const HashtagSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hashtagController = useTextEditingController();
    final hashtagNotifier = ref.read(hashtagNotifierProvider.notifier);
    final hashtags = ref.watch(hashtagNotifierProvider);

    return Column(
      children: [
        PostTextField(
          textEditingController: hashtagController,
          name: '',
          label: S.current.post_hashtags,
          maxCharacter: Constants.hashtagMaximumCharacters,
          isMandatory: false,
          textInputType: TextInputType.text,
          action: Container(
            width: AppSizes.hashtagAddButtonWidth,
            height: AppSizes.hashtagAddButtonHeight,
            padding: const EdgeInsets.all(
              AppSizes.smallSpacing,
            ),
            child: FilledButton(
              onPressed: () {
                if (hashtagController.value.text.isEmpty) return;
                hashtagNotifier.addHashtag(hashtagController.value.text);
                hashtagController.clear();
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
