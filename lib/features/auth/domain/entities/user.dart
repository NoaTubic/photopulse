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
  final double totalUploadSizeInMB;

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
    this.totalUploadSizeInMB = 0,
  });

  factory PhotoPulseUser.fromJson(Map<String, dynamic> json) =>
      _$PhotoPulseUserFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoPulseUserToJson(this);

  @override
  String toString() {
    return 'PhotoPulseUser\n id: $id \n username: $username \n email: $email \n photoUrl: $photoUrl \n isAdmin: $isAdmin \n isFirstLogin: $isFirstLogin \n subscriptionPackage: $subscriptionPackage \n dailyUploads: $dailyUploads \n maxSpend: $maxSpend \n canChangeSubscription: $canChangeSubscription \n totalUploadSizeInMB: $totalUploadSizeInMB';
  }
}
