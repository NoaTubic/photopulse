// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoPulseUser _$PhotoPulseUserFromJson(Map<String, dynamic> json) =>
    PhotoPulseUser(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String? ?? '',
      isAdmin: json['isAdmin'] as bool? ?? false,
      isFirstLogin: json['isFirstLogin'] as bool? ?? true,
      subscriptionPackage: $enumDecodeNullable(
              _$SubscriptionPackageEnumMap, json['subscriptionPackage']) ??
          SubscriptionPackage.free,
      dailyUploads: json['dailyUploads'] as int? ?? 0,
      maxSpend: json['maxSpend'] as int? ?? 0,
      canChangeSubscription: json['canChangeSubscription'] as bool? ?? true,
      totalUploadSizeInMB:
          (json['totalUploadSizeInMB'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$PhotoPulseUserToJson(PhotoPulseUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'isAdmin': instance.isAdmin,
      'isFirstLogin': instance.isFirstLogin,
      'subscriptionPackage':
          _$SubscriptionPackageEnumMap[instance.subscriptionPackage],
      'dailyUploads': instance.dailyUploads,
      'maxSpend': instance.maxSpend,
      'canChangeSubscription': instance.canChangeSubscription,
      'totalUploadSizeInMB': instance.totalUploadSizeInMB,
    };

const _$SubscriptionPackageEnumMap = {
  SubscriptionPackage.free: 'free',
  SubscriptionPackage.pro: 'pro',
  SubscriptionPackage.gold: 'gold',
};
