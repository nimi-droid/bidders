import 'package:bidders/utils/log.dart';
import 'package:dio/dio.dart';

class DioLogger {
  static void onSend(String tag, RequestOptions requestOptions) {
    Log.info(
        '$tag --> [${requestOptions.method}] ${requestOptions.baseUrl} ${requestOptions.path} ${requestOptions.queryParameters}');
    Log.info('$tag - Content type: ${requestOptions.contentType}');
    Log.info('$tag - Request Data : ${requestOptions.data.toString()}');
    Log.info('<-- END HTTP');
  }

  static void onSuccess(String tag, Response response) {
    Log.info(
        '$tag <-- ${response.statusCode} ${response.request.method} ${response.request.baseUrl} ${response.request.path} ${response.request.queryParameters}');
    Log.info(
        '$tag - Response Path : [${response.request.method}] ${response.request.baseUrl}${response.request.path} Request Data : ${response.request.data.toString()}');
    Log.info('$tag - Response status Code : ${response.statusCode}');
    Log.info('$tag - Response data : ${response.data.toString()}');
    Log.info('<-- END HTTP');
  }

  static void onError(String tag, DioError error) {
    if (null != error.response) {
      Log.info(
          '$tag - Error Path : [${error.response.request.method}] ${error.response.request.baseUrl}${error.response.request.path} Request Data : ${error.response.request.data.toString()}');
      Log.info('$tag - Error statusCode : ${error.response.statusCode}');
      Log.info(
          '$tag - Error data : ${null != error.response.data ? error.response.data.toString() : ''}');
    }
    Log.info('$tag - Error Message : ${error.message}');
  }
}
