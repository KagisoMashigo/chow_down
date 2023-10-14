import 'package:json_annotation/json_annotation.dart';

part 'error.g.dart';

enum ErrorType {
  unknown,
  network,
  server,
  unauthorized,
  forbidden,
  notFound,
  validation,
  cancelled,
  timeout,
}

@JsonSerializable()
class ApiErrorResponse {
  final int code;
  final String message;
  final String? type;
  final String? subtype;

  ApiErrorResponse({
    required this.code,
    required this.message,
    this.type,
    this.subtype,
  });

  @override
  String toString() {
    final response = '$code: $message';
    return subtype == type ? response : '$response \n\r$type: $subtype';
  }

  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorResponseToJson(this);
}

class ApiException implements Exception {
  final int code;
  final String message;
  final String? subtype;
  final String? url;

  @override
  String toString() => message;

  /// The subtype, if any
  String toSubtype() => subtype!;

  /// Copy of the HTTP Code returned
  int toCode() => code;

  ApiException._({
    required this.code,
    required this.message,
    this.subtype,
    this.url,
  });

  factory ApiException({String? url, ApiErrorResponse? response}) =>
      ApiException._(
        code: response!.code,
        message: 'ApiException code ${response.code} on $url',
        subtype: response.subtype,
        url: url,
      );
}

class Failure {
  final int? code;
  final String message;

  Failure({
    this.code,
    required this.message,
  });

  @override
  String toString() => message;
}
