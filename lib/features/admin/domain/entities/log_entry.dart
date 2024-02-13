import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photopulse/features/auth/domain/entities/user.dart';
import 'package:photopulse/features/post/domain/entities/post.dart';

@JsonSerializable()
class LogEntry {
  final String userId;
  final String documentId;
  final String collection;
  final String eventType;
  final Timestamp timestamp;
  final Object? beforeData;
  final Object? afterData;

  LogEntry({
    required this.userId,
    required this.documentId,
    required this.collection,
    required this.eventType,
    required this.timestamp,
    this.beforeData,
    this.afterData,
  });

  factory LogEntry.fromJson(Map<String, dynamic> json) => LogEntry(
        userId: json['userId'] as String,
        documentId: json['documentId'] as String,
        collection: json['collection'] as String,
        eventType: json['eventType'] as String,
        timestamp: json['timestamp'] as Timestamp,
        beforeData: json['beforeData'] == null
            ? null
            : (json['collection'] as String) == 'users'
                ? PhotoPulseUser.fromJson(
                    json['beforeData'] as Map<String, dynamic>)
                : Post.fromJson(json['beforeData'] as Map<String, dynamic>),
        afterData: (json['collection'] as String) == 'users'
            ? PhotoPulseUser.fromJson(json['afterData'] as Map<String, dynamic>)
            : Post.fromJson(json['afterData'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'documentId': documentId,
        'collection': collection,
        'eventType': eventType,
        'timestamp': timestamp,
        'beforeData': beforeData,
        'afterData': afterData,
      };
}
