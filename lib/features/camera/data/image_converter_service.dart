import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final imageConverterServiceProvider =
    Provider<ImageConverterService>((ref) => HeicConverterServiceImpl());

abstract class ImageConverterService {
  Future<File> convertHeicOrHeifToJpeg(File imageFile);
}

class HeicConverterServiceImpl implements ImageConverterService {
  @override
  Future<File> convertHeicOrHeifToJpeg(File imageFile) async {
    if (!_isHeicOrHeifFile(imageFile)) return imageFile;
    final tempDir = (await getTemporaryDirectory()).path;
    final targetPath = '$tempDir/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final result = await FlutterImageCompress.compressAndGetFile(
      imageFile.path,
      targetPath,
      format: CompressFormat.jpeg,
      quality: 90,
    );
    final File resizedImage = File(result!.path);
    return resizedImage;
  }
}

bool _isHeicOrHeifFile(File file) {
  final fileExtension = file.path.split('.').last;
  return fileExtension == 'heic' ||
      fileExtension == 'HEIC' ||
      fileExtension == 'heif' ||
      fileExtension == 'HEIF' ||
      fileExtension == 'hevc' ||
      fileExtension == 'HEVC';
}
