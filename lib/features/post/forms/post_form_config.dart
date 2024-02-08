//ignore_for_file: always_use_package_imports

import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/features/post/domain/entities/post_form_data.dart';
import 'package:q_architecture/q_architecture.dart';

final postRequestFormMapperProvider = Provider<FormMapper<PostFormData>>(
  (_) => PostFormConfig.postUpdateRequestFromJson,
);

abstract class PostFormConfig {
  static const filePathKey = 'file';
  static const titleKey = 'title';
  static const captionKey = 'caption';

  static PostFormData postUpdateRequestFromJson(
    Map<String, dynamic> formMap,
  ) =>
      PostFormData(
        title: formMap[titleKey] ?? '',
        caption: formMap[captionKey],
      );

  static PostFormData postCreateRequestFromJson(
    Map<String, dynamic> formMap,
  ) =>
      PostFormData(
        title: formMap[titleKey] ?? '',
        caption: formMap[captionKey],
        filePath: formMap[filePathKey],
      );

  static String? Function(T?) required<T>() => FormBuilderValidators.required();
}
