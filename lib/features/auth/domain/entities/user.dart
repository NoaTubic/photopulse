import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photopulse/features/subscription_management/domain/entities/subscription_package.dart';

part 'user.g.dart';

@JsonSerializable()
class PhotoPulseUser {
  final String id;
  final String username;
  final String email;
  final String? photoUrl;
  final bool? isAdmin;
  final bool isFirstLogin;
  final SubscriptionPackage? subscriptionPackage;
  final int dailyUploads;
  final int maxSpend;
  final bool canChangeSubscription;

  PhotoPulseUser({
    required this.id,
    required this.username,
    required this.email,
    this.photoUrl = '',
    this.isAdmin = false,
    this.isFirstLogin = true,
    this.subscriptionPackage = SubscriptionPackage.free,
    this.dailyUploads = 0,
    this.maxSpend = 0,
    this.canChangeSubscription = true,
  });

  factory PhotoPulseUser.fromJson(Map<String, dynamic> json) =>
      _$PhotoPulseUserFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoPulseUserToJson(this);
}
