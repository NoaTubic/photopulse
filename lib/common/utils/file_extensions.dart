import 'dart:io';

extension FileSizeExtension on File {
  double get sizeInMB {
    final bytes = readAsBytesSync().lengthInBytes;
    final sizeInKb = bytes / 1024;
    final sizeInMb = sizeInKb / 1024;
    return sizeInMb;
  }
}
