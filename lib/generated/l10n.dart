// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Unknown error occurred`
  String get unknown_error_occurred {
    return Intl.message(
      'Unknown error occurred',
      name: 'unknown_error_occurred',
      desc: '',
      args: [],
    );
  }

  /// `Permission has been denied, please enable it in device settings`
  String get permission_denied {
    return Intl.message(
      'Permission has been denied, please enable it in device settings',
      name: 'permission_denied',
      desc: '',
      args: [],
    );
  }

  /// `PhotoPulse`
  String get photo_pulse {
    return Intl.message(
      'PhotoPulse',
      name: 'photo_pulse',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get required_field {
    return Intl.message(
      'This field is required',
      name: 'required_field',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password to continue.`
  String get enter_your_password {
    return Intl.message(
      'Please enter your password to continue.',
      name: 'enter_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email to continue.`
  String get enter_your_email {
    return Intl.message(
      'Please enter your email to continue.',
      name: 'enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Your email`
  String get your_email {
    return Intl.message(
      'Your email',
      name: 'your_email',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your username to continue.`
  String get enter_your_username {
    return Intl.message(
      'Please enter your username to continue.',
      name: 'enter_your_username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirm_password {
    return Intl.message(
      'Confirm password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Your password`
  String get your_password {
    return Intl.message(
      'Your password',
      name: 'your_password',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get login {
    return Intl.message(
      'Log In',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email format`
  String get invalid_email_format {
    return Intl.message(
      'Invalid email format',
      name: 'invalid_email_format',
      desc: '',
      args: [],
    );
  }

  /// `Invalid password format`
  String get invalid_password_format {
    return Intl.message(
      'Invalid password format',
      name: 'invalid_password_format',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get required_email {
    return Intl.message(
      'Email is required',
      name: 'required_email',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account?`
  String get dont_have_account {
    return Intl.message(
      'Don’t have an account?',
      name: 'dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Create new account`
  String get create_new_account {
    return Intl.message(
      'Create new account',
      name: 'create_new_account',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forgot_password {
    return Intl.message(
      'Forgot your password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address to reset your password.`
  String get forgot_password_helper {
    return Intl.message(
      'Please enter your email address to reset your password.',
      name: 'forgot_password_helper',
      desc: '',
      args: [],
    );
  }

  /// `Password reset email has been sent`
  String get password_reset_email_sent {
    return Intl.message(
      'Password reset email has been sent',
      name: 'password_reset_email_sent',
      desc: '',
      args: [],
    );
  }

  /// `Continue without signing in`
  String get anonymous_login {
    return Intl.message(
      'Continue without signing in',
      name: 'anonymous_login',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email and password combination`
  String get login_error_wrong_credentials {
    return Intl.message(
      'Invalid email and password combination',
      name: 'login_error_wrong_credentials',
      desc: '',
      args: [],
    );
  }

  /// `Email already in use`
  String get login_error_email_already_in_user {
    return Intl.message(
      'Email already in use',
      name: 'login_error_email_already_in_user',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password is required`
  String get confirm_password_required {
    return Intl.message(
      'Confirm password is required',
      name: 'confirm_password_required',
      desc: '',
      args: [],
    );
  }

  /// `Passwords don't match`
  String get passwords_dont_match {
    return Intl.message(
      'Passwords don\'t match',
      name: 'passwords_dont_match',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get reset_password {
    return Intl.message(
      'Reset Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Go back`
  String get go_back {
    return Intl.message(
      'Go back',
      name: 'go_back',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Verify Email`
  String get verify_email {
    return Intl.message(
      'Verify Email',
      name: 'verify_email',
      desc: '',
      args: [],
    );
  }

  /// `Almost ready to start using`
  String get verify_email_subtitle {
    return Intl.message(
      'Almost ready to start using',
      name: 'verify_email_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Please check your inbox and verify your email address.`
  String get verify_email_helper {
    return Intl.message(
      'Please check your inbox and verify your email address.',
      name: 'verify_email_helper',
      desc: '',
      args: [],
    );
  }

  /// `Didn't receive verification email?  `
  String get didnt_receive_verification_email {
    return Intl.message(
      'Didn\'t receive verification email?  ',
      name: 'didnt_receive_verification_email',
      desc: '',
      args: [],
    );
  }

  /// `Resend `
  String get resend_verification_email {
    return Intl.message(
      'Resend ',
      name: 'resend_verification_email',
      desc: '',
      args: [],
    );
  }

  /// `Verification email has been sent`
  String get verification_email_resend_success {
    return Intl.message(
      'Verification email has been sent',
      name: 'verification_email_resend_success',
      desc: '',
      args: [],
    );
  }

  /// `Email not verified. Please check your email for verification link.`
  String get email_not_verified {
    return Intl.message(
      'Email not verified. Please check your email for verification link.',
      name: 'email_not_verified',
      desc: '',
      args: [],
    );
  }

  /// `Server error occurred`
  String get server_error {
    return Intl.message(
      'Server error occurred',
      name: 'server_error',
      desc: '',
      args: [],
    );
  }

  /// `Google sign in cancelled`
  String get google_sign_in_canceled {
    return Intl.message(
      'Google sign in cancelled',
      name: 'google_sign_in_canceled',
      desc: '',
      args: [],
    );
  }

  /// `User not found`
  String get user_not_found {
    return Intl.message(
      'User not found',
      name: 'user_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home_tab {
    return Intl.message(
      'Home',
      name: 'home_tab',
      desc: '',
      args: [],
    );
  }

  /// `Upload content`
  String get upload_content_tab {
    return Intl.message(
      'Upload content',
      name: 'upload_content_tab',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search_tab {
    return Intl.message(
      'Search',
      name: 'search_tab',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile_tab {
    return Intl.message(
      'Profile',
      name: 'profile_tab',
      desc: '',
      args: [],
    );
  }

  /// `Maximum image size is 50 MB`
  String get max_image_size_error {
    return Intl.message(
      'Maximum image size is 50 MB',
      name: 'max_image_size_error',
      desc: '',
      args: [],
    );
  }

  /// `Canceled`
  String get canceled {
    return Intl.message(
      'Canceled',
      name: 'canceled',
      desc: '',
      args: [],
    );
  }

  /// `For taking photos, please allow the PhotoPulse app access to your camera.`
  String get camera_permissions_dialog_error_text {
    return Intl.message(
      'For taking photos, please allow the PhotoPulse app access to your camera.',
      name: 'camera_permissions_dialog_error_text',
      desc: '',
      args: [],
    );
  }

  /// `Go to your settings > Permissions and turn on the camera.`
  String get camera_permissions_dialog_helper_text {
    return Intl.message(
      'Go to your settings > Permissions and turn on the camera.',
      name: 'camera_permissions_dialog_helper_text',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get body_text_cancel {
    return Intl.message(
      'Cancel',
      name: 'body_text_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Retake`
  String get body_text_retake {
    return Intl.message(
      'Retake',
      name: 'body_text_retake',
      desc: '',
      args: [],
    );
  }

  /// `Create post`
  String get create_post_button {
    return Intl.message(
      'Create post',
      name: 'create_post_button',
      desc: '',
      args: [],
    );
  }

  /// `Create new post`
  String get create_new_post {
    return Intl.message(
      'Create new post',
      name: 'create_new_post',
      desc: '',
      args: [],
    );
  }

  /// `Update post`
  String get update_post {
    return Intl.message(
      'Update post',
      name: 'update_post',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get post_title {
    return Intl.message(
      'Title',
      name: 'post_title',
      desc: '',
      args: [],
    );
  }

  /// `Caption`
  String get post_caption {
    return Intl.message(
      'Caption',
      name: 'post_caption',
      desc: '',
      args: [],
    );
  }

  /// `Hashtags`
  String get post_hashtags {
    return Intl.message(
      'Hashtags',
      name: 'post_hashtags',
      desc: '',
      args: [],
    );
  }

  /// `Upload Content`
  String get upload_content {
    return Intl.message(
      'Upload Content',
      name: 'upload_content',
      desc: '',
      args: [],
    );
  }

  /// `Take photo`
  String get take_photo {
    return Intl.message(
      'Take photo',
      name: 'take_photo',
      desc: '',
      args: [],
    );
  }

  /// `Retake`
  String get retake {
    return Intl.message(
      'Retake',
      name: 'retake',
      desc: '',
      args: [],
    );
  }

  /// `Load from gallery`
  String get load_from_gallery {
    return Intl.message(
      'Load from gallery',
      name: 'load_from_gallery',
      desc: '',
      args: [],
    );
  }

  /// `Subscription Package`
  String get subscription_package {
    return Intl.message(
      'Subscription Package',
      name: 'subscription_package',
      desc: '',
      args: [],
    );
  }

  /// `For uploading photos, please allow the PhotoPulse app access to your gallery.`
  String get gallery_permissions_dialog_error {
    return Intl.message(
      'For uploading photos, please allow the PhotoPulse app access to your gallery.',
      name: 'gallery_permissions_dialog_error',
      desc: '',
      args: [],
    );
  }

  /// `Go to you settings > Permissions and turn on the photos and storage`
  String get gallery_permissions_dialog_helper {
    return Intl.message(
      'Go to you settings > Permissions and turn on the photos and storage',
      name: 'gallery_permissions_dialog_helper',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get error_message_something_wrong {
    return Intl.message(
      'Something went wrong',
      name: 'error_message_something_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Please choose a prescription package`
  String get headline_choose_prescription_package {
    return Intl.message(
      'Please choose a prescription package',
      name: 'headline_choose_prescription_package',
      desc: '',
      args: [],
    );
  }

  /// `Choose package`
  String get button_label_choose_package {
    return Intl.message(
      'Choose package',
      name: 'button_label_choose_package',
      desc: '',
      args: [],
    );
  }

  /// `Upload size:`
  String get upload_size {
    return Intl.message(
      'Upload size:',
      name: 'upload_size',
      desc: '',
      args: [],
    );
  }

  /// `Uploaded today:`
  String get uploaded_today {
    return Intl.message(
      'Uploaded today:',
      name: 'uploaded_today',
      desc: '',
      args: [],
    );
  }

  /// `Daily upload limit:`
  String get daily_upload_limit {
    return Intl.message(
      'Daily upload limit:',
      name: 'daily_upload_limit',
      desc: '',
      args: [],
    );
  }

  /// `Maximum spend:`
  String get max_spend {
    return Intl.message(
      'Maximum spend:',
      name: 'max_spend',
      desc: '',
      args: [],
    );
  }

  /// `Change subscription`
  String get change_subscription {
    return Intl.message(
      'Change subscription',
      name: 'change_subscription',
      desc: '',
      args: [],
    );
  }

  /// `You can only change your subscription package once a day`
  String get change_subscription_error {
    return Intl.message(
      'You can only change your subscription package once a day',
      name: 'change_subscription_error',
      desc: '',
      args: [],
    );
  }

  /// `There are no posts yet.\nAdd a new one on 'Upload  content Tab'.`
  String get no_posts_yet {
    return Intl.message(
      'There are no posts yet.\nAdd a new one on \'Upload  content Tab\'.',
      name: 'no_posts_yet',
      desc: '',
      args: [],
    );
  }

  /// `For downloading photos, please allow the PhotoPulse app access to your storage.`
  String get storage_permission_dialog_error_text {
    return Intl.message(
      'For downloading photos, please allow the PhotoPulse app access to your storage.',
      name: 'storage_permission_dialog_error_text',
      desc: '',
      args: [],
    );
  }

  /// `Go to you settings > Permissions and turn on the photos and storage`
  String get storage_permission_dialog_helper_text {
    return Intl.message(
      'Go to you settings > Permissions and turn on the photos and storage',
      name: 'storage_permission_dialog_helper_text',
      desc: '',
      args: [],
    );
  }

  /// `Successfully saved`
  String get successfully_saved {
    return Intl.message(
      'Successfully saved',
      name: 'successfully_saved',
      desc: '',
      args: [],
    );
  }

  /// `Whoops`
  String get whoops {
    return Intl.message(
      'Whoops',
      name: 'whoops',
      desc: '',
      args: [],
    );
  }

  /// `Filters`
  String get filters {
    return Intl.message(
      'Filters',
      name: 'filters',
      desc: '',
      args: [],
    );
  }

  /// `Filter by user`
  String get filter_by_user {
    return Intl.message(
      'Filter by user',
      name: 'filter_by_user',
      desc: '',
      args: [],
    );
  }

  /// `Min Size in MB`
  String get min_size_in_mb {
    return Intl.message(
      'Min Size in MB',
      name: 'min_size_in_mb',
      desc: '',
      args: [],
    );
  }

  /// `Max Size in MB`
  String get max_size_in_mb {
    return Intl.message(
      'Max Size in MB',
      name: 'max_size_in_mb',
      desc: '',
      args: [],
    );
  }

  /// `Sort by size`
  String get sort_by_size {
    return Intl.message(
      'Sort by size',
      name: 'sort_by_size',
      desc: '',
      args: [],
    );
  }

  /// `Sort by date`
  String get sort_by_date {
    return Intl.message(
      'Sort by date',
      name: 'sort_by_date',
      desc: '',
      args: [],
    );
  }

  /// `Ascending`
  String get ascending {
    return Intl.message(
      'Ascending',
      name: 'ascending',
      desc: '',
      args: [],
    );
  }

  /// `Descending`
  String get descending {
    return Intl.message(
      'Descending',
      name: 'descending',
      desc: '',
      args: [],
    );
  }

  /// `Select date range`
  String get select_date_range {
    return Intl.message(
      'Select date range',
      name: 'select_date_range',
      desc: '',
      args: [],
    );
  }

  /// `Apply filters`
  String get apply_filters {
    return Intl.message(
      'Apply filters',
      name: 'apply_filters',
      desc: '',
      args: [],
    );
  }

  /// `Select user`
  String get select_user {
    return Intl.message(
      'Select user',
      name: 'select_user',
      desc: '',
      args: [],
    );
  }

  /// `View more`
  String get view_more {
    return Intl.message(
      'View more',
      name: 'view_more',
      desc: '',
      args: [],
    );
  }

  /// `View less`
  String get view_less {
    return Intl.message(
      'View less',
      name: 'view_less',
      desc: '',
      args: [],
    );
  }

  /// `Edit post`
  String get edit_post {
    return Intl.message(
      'Edit post',
      name: 'edit_post',
      desc: '',
      args: [],
    );
  }

  /// `Download post`
  String get download_post {
    return Intl.message(
      'Download post',
      name: 'download_post',
      desc: '',
      args: [],
    );
  }

  /// `Delete post`
  String get delete_post {
    return Intl.message(
      'Delete post',
      name: 'delete_post',
      desc: '',
      args: [],
    );
  }

  /// `For downloading post content, please allow the Care Connect app to access your gallery and storage.`
  String get download_post_content_permission_gallery_and_storage {
    return Intl.message(
      'For downloading post content, please allow the Care Connect app to access your gallery and storage.',
      name: 'download_post_content_permission_gallery_and_storage',
      desc: '',
      args: [],
    );
  }

  /// `For downloading post content, please allow the Care Connect app to access your gallery.`
  String get download_post_content_permission_gallery {
    return Intl.message(
      'For downloading post content, please allow the Care Connect app to access your gallery.',
      name: 'download_post_content_permission_gallery',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to go back?`
  String get confirm_go_back_title {
    return Intl.message(
      'Are you sure you want to go back?',
      name: 'confirm_go_back_title',
      desc: '',
      args: [],
    );
  }

  /// `If you go back now, the changes you made will be lost.`
  String get changes_will_be_lost_body {
    return Intl.message(
      'If you go back now, the changes you made will be lost.',
      name: 'changes_will_be_lost_body',
      desc: '',
      args: [],
    );
  }

  /// `Admin panel`
  String get admin_panel {
    return Intl.message(
      'Admin panel',
      name: 'admin_panel',
      desc: '',
      args: [],
    );
  }

  /// `Change username`
  String get change_username {
    return Intl.message(
      'Change username',
      name: 'change_username',
      desc: '',
      args: [],
    );
  }

  /// `Change email`
  String get change_email {
    return Intl.message(
      'Change email',
      name: 'change_email',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get delete_account {
    return Intl.message(
      'Delete Account',
      name: 'delete_account',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `User statistics`
  String get user_statistics {
    return Intl.message(
      'User statistics',
      name: 'user_statistics',
      desc: '',
      args: [],
    );
  }

  /// `User actions`
  String get user_actions {
    return Intl.message(
      'User actions',
      name: 'user_actions',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get id {
    return Intl.message(
      'ID',
      name: 'id',
      desc: '',
      args: [],
    );
  }

  /// `Is admin`
  String get is_admin {
    return Intl.message(
      'Is admin',
      name: 'is_admin',
      desc: '',
      args: [],
    );
  }

  /// `Daily uploads`
  String get daily_uploads {
    return Intl.message(
      'Daily uploads',
      name: 'daily_uploads',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get none {
    return Intl.message(
      'None',
      name: 'none',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Edit user info`
  String get edit_user {
    return Intl.message(
      'Edit user info',
      name: 'edit_user',
      desc: '',
      args: [],
    );
  }

  /// `Clear statistics`
  String get clear_statistics {
    return Intl.message(
      'Clear statistics',
      name: 'clear_statistics',
      desc: '',
      args: [],
    );
  }

  /// `Upload limit reached. Upload more tomorrow or upgrade your subscription package.`
  String get upload_limit_reached {
    return Intl.message(
      'Upload limit reached. Upload more tomorrow or upgrade your subscription package.',
      name: 'upload_limit_reached',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect password format`
  String get incorrect_password_format {
    return Intl.message(
      'Incorrect password format',
      name: 'incorrect_password_format',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'hr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
