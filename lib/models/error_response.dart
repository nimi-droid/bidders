import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) => ErrorResponse.fromJson(json.decode(str));

String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  ErrorResponse({
    this.statusCode,
    this.error,
    this.apiIdentifier,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        statusCode: json['statusCode'],
        error: json['error'] == null ? null : Error.fromJson(json['error']),
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'error': error == null ? null : error.toJson(),
      };

  int statusCode;
  Error error;
  String apiIdentifier;
}

class Error {
  Error({this.name, this.code, this.message, this.customCode, this.statusCode});

  Error.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    message = json['message'];
    customCode = json['customCode'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['message'] = message;
    data['customCode'] = customCode;
    data['statusCode'] = statusCode;
    return data;
  }

  String name;
  String code;
  String message;
  String customCode;
  int statusCode;
}
