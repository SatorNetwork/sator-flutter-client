import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:intl/intl.dart';
import 'package:satorio/data/datasource/exception/api_error_exception.dart';
import 'package:satorio/data/datasource/exception/api_kyc_exception.dart';
import 'package:satorio/data/datasource/exception/api_unauthorized_exception.dart';
import 'package:satorio/data/datasource/exception/api_validation_exception.dart';
import 'package:satorio/data/model/to_json_interface.dart';
import 'package:satorio/data/response/error_response.dart';
import 'package:satorio/data/response/error_validation_response.dart';
import 'package:sprintf/sprintf.dart';

extension Format on String {
  String format(List args) {
    return sprintf(this, args);
  }
}

extension Ellipsize on String {
  String ellipsize({int startCount = 6, int endCount = 6}) {
    if (this.length <= startCount + endCount)
      return this;
    else
      return '${this.substring(0, startCount)}...${this.substring(length - endCount, length)}';
  }
}

extension Capitalize on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

extension EmailValidation on String {
  bool isEmail() {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(this);
  }
}

extension LinkValidation on String {
  bool isLink() {
    // return Uri.tryParse(this)?.isAbsolute ?? false;
    return RegExp(
      r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?",
      caseSensitive: false,
    ).hasMatch(this);
  }
}

extension StringParseHelper on String {
  double? tryParse() {
    String locale = Get.deviceLocale.toString();
    try {
      return NumberFormat.decimalPattern(locale).parse(this).toDouble();
    } catch (FormatException) {
      return null;
    }
  }
}

extension GetConnectHttpMethods on GetConnect {
  Future<Response> requestGet(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    return await this.get(path, query: query).then(
          (Response response) => processResponse(response),
        );
  }

  Future<Response> requestPost(
    String path,
    ToJsonInterface request, {
    Map<String, dynamic>? query,
  }) async {
    return await this.post(path, request.toJson(), query: query).then(
          (Response response) => processResponse(response),
        );
  }

  Future<Response> requestPut(
    String path,
    ToJsonInterface request, {
    Map<String, dynamic>? query,
  }) async {
    return await this.put(path, request.toJson(), query: query).then(
          (Response response) => processResponse(response),
        );
  }

  Future<Response> requestPatch(
    String path,
    ToJsonInterface request, {
    Map<String, dynamic>? query,
  }) async {
    return await this.patch(path, request.toJson(), query: query).then(
          (Response response) => processResponse(response),
        );
  }

  Future<Response> requestDelete(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    return await this.delete(path, query: query).then(
          (Response response) => processResponse(response),
        );
  }

  Response processResponse(Response response) {
    _logResponse(response);

    if (response.hasError) {
      switch (response.statusCode) {
        // 422
        case HttpStatus.unprocessableEntity:
          ErrorValidationResponse errorValidationResponse =
              ErrorValidationResponse.fromJson(
                  json.decode(response.bodyString!));
          throw ApiValidationException(errorValidationResponse.validation);
        // 401
        case HttpStatus.unauthorized:
          ErrorResponse errorResponse =
              ErrorResponse.fromJson(json.decode(response.bodyString!));
          throw ApiUnauthorizedException(errorResponse.error);
        // 407
        case HttpStatus.proxyAuthenticationRequired:
          throw ApiKycException();
        default:
          ErrorResponse errorResponse =
              ErrorResponse.fromJson(json.decode(response.bodyString!));
          throw ApiErrorException(errorResponse.error);
      }
    }

    return response;
  }

  void _logResponse(Response response) {
    print('--------');

    // print('Request headers:');
    // response.request!.headers.forEach((key, value) {
    //   print('   $key : $value');
    // });
    print(
        '${response.request!.method.toUpperCase()} ${response.request!.url} ${response.statusCode}');

    // print('Response headers:');
    // response.headers!.forEach((key, value) {
    //   print('   $key : $value');
    // });
    print('${response.bodyString}');
    print('--------');
  }
}

extension JsonParseHelper on Map {
  String parseValueAsString(String key, {String defValue = ''}) {
    return this[key] == null ? defValue : this[key];
  }

  bool parseValueAsBool(String key, {bool defValue = false}) {
    return this[key] == null ? defValue : this[key];
  }

  int parseValueAsInt(String key, {int defValue = 0}) {
    return this[key] == null ? defValue : this[key];
  }

  double parseValueAsDouble(String key, {double defValue = 0.0}) {
    if (this[key] == null)
      return defValue;
    else if (this[key] is int)
      return (this[key] as int).toDouble();
    else
      return this[key];
  }

  DateTime? tryParseValueAsDateTime(String key) {
    DateTime? result;
    if (this[key] != null) {
      result = DateTime.tryParse(this[key]);
    }
    return result;
  }
}
