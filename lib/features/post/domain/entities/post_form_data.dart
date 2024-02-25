class PostFormData {
  final String title;
  final String caption;
  final String? filePath;

  PostFormData({
    required this.title,
    required this.caption,
    this.filePath,
  });
}
