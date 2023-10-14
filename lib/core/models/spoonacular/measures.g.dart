// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measures.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Measures _$MeasuresFromJson(Map<String, dynamic> json) => Measures(
      us: json['us'] == null
          ? null
          : Us.fromJson(json['us'] as Map<String, dynamic>),
      metric: json['metric'] == null
          ? null
          : Metric.fromJson(json['metric'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MeasuresToJson(Measures instance) => <String, dynamic>{
      'us': instance.us,
      'metric': instance.metric,
    };
