import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Metric {
  final double? amount;
  final String? unitShort;
  final String? unitLong;

  Metric({
    this.amount,
    this.unitShort,
    this.unitLong,
  });

  factory Metric.fromJson(json) => Metric(
        amount: (json['amount'] as num).toDouble(),
        unitShort: json['unitShort'] as String,
        unitLong: json['unitLong'] as String,
      );

  toJson() => {
        'amount': amount,
        'unitShort': unitShort,
        'unitLong': unitLong,
      };
}
