import 'package:json_annotation/json_annotation.dart';

part 'us.g.dart';

@JsonSerializable()
class Us {
  final double amount;
  final String? unitShort;
  final String? unitLong;

  Us({
    required this.amount,
    this.unitShort,
    this.unitLong,
  });

  factory Us.fromJson(Map<String, dynamic> json) => _$UsFromJson(json);

  Map<String, dynamic> toJson() => _$UsToJson(this);
}
