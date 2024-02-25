import 'dart:io';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:photopulse/theme/app_colors.dart';

final imageCropperServiceProvider = Provider<ImageCropperService>((ref) {
  return ImageCropperServiceImpl();
});

abstract class ImageCropperService {
  Future<File> cropImage(File imageFile);
}

class ImageCropperServiceImpl implements ImageCropperService {
  @override
  Future<File> cropImage(File imageFile) async {
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: S.current.edit_image,
          toolbarColor: AppColors.white,
          toolbarWidgetColor: AppColors.black,
          activeControlsWidgetColor: AppColors.black,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
      ],
    );
    return File(croppedFile?.path ?? '');
  }
}
