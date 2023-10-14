// 🌎 Project imports:
import 'package:chow_down/core/models/spoonacular/metric.dart';
import 'package:chow_down/core/models/spoonacular/us.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Measures {
  final Us? us;
  final Metric? metric;

  Measures({
    this.us,
    this.metric,
  });

  factory Measures.fromJson(Map<String, dynamic> json) {
    return Measures(
      us: Us.fromJson(json['us']),
      metric: Metric.fromJson(json['metric']),
    );
  }

  toJson() => {
        'us': us?.toJson(),
        'metric': metric?.toJson(),
      };
}
