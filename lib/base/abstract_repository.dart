import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/error_response.dart';
import '../utils/utils.dart';

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
