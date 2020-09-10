import 'package:bidders/models/error_response.dart';
import 'package:bidders/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class AbstractRepository {
  BuildContext mContext;

  dynamic onSuccess(String endPoint, Response response) {
    Utils.hideLoader();
  }

  dynamic onError(String endPoint, ErrorResponse response) {
    Utils.hideLoader();
    Utils.showValidationMessage(mContext, response.error.message);
    return response;
  }
}
