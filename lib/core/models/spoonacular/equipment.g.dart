// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Equipment _$EquipmentFromJson(Map<String, dynamic> json) => Equipment(
      id: json['id'] as int,
      localizedName: json['localizedName'] as String?,
      name: json['name'] as String,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$EquipmentToJson(Equipment instance) => <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'id': instance.id,
      'localizedName': instance.localizedName,
    };

EquipmentList _$EquipmentListFromJson(Map<String, dynamic> json) =>
    EquipmentList(
      items: (json['items'] as List<dynamic>)
          .map((e) => Equipment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EquipmentListToJson(EquipmentList instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
