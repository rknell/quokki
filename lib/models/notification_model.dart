/// A message is a notification for a user, usually a response to a post or
/// comment

import 'package:json_annotation/json_annotation.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'db_model.dart';
import 'json_helpers.dart';

part 'notification_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Notification extends DbModel {
  final String joeyId;

  @JsonKey(
      fromJson: JSONHelpers.fromJsonObjectId,
      toJson: JSONHelpers.toJsonObjectId)
  final ObjectId postId;

  @JsonKey(
      fromJson: JSONHelpers.fromJsonObjectIdNullable,
      toJson: JSONHelpers.toJsonObjectIdNullable)
  final ObjectId? commentId;
  bool isRead;

  final String body;
  final String author;

  String get notificationUrl {
    if (commentId == null) {
      return "/j/$joeyId/comments/${postId.toHexString()}";
    } else {
      return "/j/$joeyId/comments/${postId.toHexString()}/comment/${commentId}";
    }
  }

  Notification({
    required this.postId,
    this.isRead = false,
    this.commentId,
    required this.joeyId,
    required this.body,
    required this.author,
    super.id,
  });

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);

  Notification fromJson(Map<String, dynamic> json) =>
      Notification.fromJson(json);
}
