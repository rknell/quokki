// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joey_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Joey _$JoeyFromJson(Map<String, dynamic> json) => Joey(
      displayName: json['displayName'] as String,
      idName: json['idName'] as String,
      description: json['description'] as String,
      mods: (json['mods'] as List<dynamic>?)?.map((e) => e as String).toSet(),
      id: JSONHelpers.fromJsonObjectId(json['_id']),
    );

Map<String, dynamic> _$JoeyToJson(Joey instance) => <String, dynamic>{
      '_id': JSONHelpers.toJsonObjectId(instance.id),
      'displayName': instance.displayName,
      'idName': instance.idName,
      'description': instance.description,
      'mods': instance.mods.toList(),
    };
