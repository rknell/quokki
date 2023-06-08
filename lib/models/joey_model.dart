import 'package:json_annotation/json_annotation.dart';
import 'package:quokki/models/db_model.dart';

import 'json_helpers.dart';

part 'joey_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Joey extends DbModel {
  String displayName;
  String idName;
  String description;

  /// Represents a userId that can moderate the cent
  final Set<String> mods;
  Joey(
      {required this.displayName,
      required this.idName,
      required this.description,
      Set<String>? mods,
      super.id})
      : mods = mods ?? <String>{};

  factory Joey.fromJson(Map<String, dynamic> json) => _$JoeyFromJson(json);

  Map<String, dynamic> toJson() => _$JoeyToJson(this);

  Joey fromJson(Map<String, dynamic> json) => Joey.fromJson(json);
}
