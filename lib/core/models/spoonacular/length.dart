// 📦 Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'length.g.dart';

@JsonSerializable()
class Length {
  final int? number;
  final String? unit;

  Length({
    this.number,
    this.unit,
  });

  factory Length.fromJson(Map<String, dynamic> json) => _$LengthFromJson(json);

  Map<String, dynamic> toJson() => _$LengthToJson(this);
}
