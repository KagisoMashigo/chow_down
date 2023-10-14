// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysed_instructions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalyzedInstruction _$AnalyzedInstructionFromJson(Map<String, dynamic> json) =>
    AnalyzedInstruction(
      name: json['name'] as String,
      steps: (json['steps'] as List<dynamic>)
          .map((e) => Step.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnalyzedInstructionToJson(
        AnalyzedInstruction instance) =>
    <String, dynamic>{
      'name': instance.name,
      'steps': instance.steps,
    };
