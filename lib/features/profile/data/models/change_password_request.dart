class ChangePasswordRequest {
  final String oldPassword;
  final String newPassword;
  final String repeatNewPassword;

  ChangePasswordRequest({
    required this.oldPassword,
    required this.newPassword,
    required this.repeatNewPassword,
  });
}
