// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      postId: JSONHelpers.fromJsonObjectId(json['postId']),
      isRead: json['isRead'] as bool? ?? false,
      commentId: JSONHelpers.fromJsonObjectIdNullable(json['commentId']),
      joeyId: json['joeyId'] as String,
      body: json['body'] as String,
      author: json['author'] as String,
      id: JSONHelpers.fromJsonObjectId(json['_id']),
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      '_id': JSONHelpers.toJsonObjectId(instance.id),
      'joeyId': instance.joeyId,
      'postId': JSONHelpers.toJsonObjectId(instance.postId),
      'commentId': JSONHelpers.toJsonObjectIdNullable(instance.commentId),
      'isRead': instance.isRead,
      'body': instance.body,
      'author': instance.author,
    };
