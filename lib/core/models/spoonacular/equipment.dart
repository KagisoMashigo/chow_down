import 'package:json_annotation/json_annotation.dart';

part 'equipment.g.dart';

@JsonSerializable()
class Equipment {
  final String name;
  final String? image;
  final int id;
  final String? localizedName;
  Equipment({
    required this.id,
    this.localizedName,
    required this.name,
    this.image,
  });

  factory Equipment.fromJson(Map<String, dynamic> json) =>
      _$EquipmentFromJson(json);

  Map<String, dynamic> toJson() => _$EquipmentToJson(this);
}

@JsonSerializable()
class EquipmentList {
  final List<Equipment> items;
  EquipmentList({
    required this.items,
  });

  factory EquipmentList.fromJson(Map<String, dynamic> json) =>
      _$EquipmentListFromJson(json);

  Map<String, dynamic> toJson() => _$EquipmentListToJson(this);
}
