import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photopulse/features/camera/data/image_converter_service.dart';
import 'package:photopulse/features/camera/data/image_cropper_service.dart';
import 'package:photopulse/features/camera/data/providers.dart';
import 'package:q_architecture/q_architecture.dart';

final imageGalleryServiceProvider = Provider<ImageGalleryService>(
  (ref) => ImageGalleryServiceImpl(
    ref.watch(imagePickerProvider),
    ref.watch(imageCropperServiceProvider),
    ref.watch(imageConverterServiceProvider),
  ),
);

abstract class ImageGalleryService {
  EitherFailureOr<File> loadImage({bool crop});
}

class ImageGalleryServiceImpl implements ImageGalleryService {
  final ImagePicker _imagePicker;
  final ImageCropperService _imageCropperService;
  final ImageConverterService _heicConverterService;

  ImageGalleryServiceImpl(
    this._imagePicker,
    this._imageCropperService,
    this._heicConverterService,
  );

  @override
  EitherFailureOr<File> loadImage({bool crop = true}) async {
    File image;
    try {
      final pickedImage =
          await _imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedImage == null) {
        return Left(
          Failure.generic(title: 'Canceled'),
        );
      } else {
        image = await _heicConverterService
            .convertHeicOrHeifToJpeg(File(pickedImage.path));
        final isFileValid = _isFileValid(file: image, maxSize: maxImageSize);
        if (isFileValid) {
          return Right(
            crop ? await _imageCropperService.cropImage(image) : image,
          );
        } else {
          return Left(Failure.generic(title: 'Maximum image size is 50 MB'));
        }
      }
    } on PlatformException catch (_) {
      return Left(Failure.generic());
    }
  }
}

bool _isFileValid({required File file, required double maxSize}) {
  final bytes = file.readAsBytesSync().lengthInBytes;
  final sizeInKb = bytes / 1024;
  final sizeInMb = sizeInKb / 1024;
  if (sizeInMb > maxSize) {
    return false;
  }
  return true;
}

const double maxImageSize = 50;
const String videoExtension = '.mp4';
