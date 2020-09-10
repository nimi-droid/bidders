import 'package:package_info/package_info.dart';

// ignore: avoid_classes_with_only_static_members
class KGlobal {
  // ignore: non_constant_identifier_names
  static final Future<String> APP_VERSION = _getVersionNumber();

  static Future<String> _getVersionNumber() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return 'v' + packageInfo.version + '+' + packageInfo.buildNumber;
  }

  //Global constants
  static const TIME_OUT_DURATION = Duration(seconds: 10);
  static const CONNECT_TIMEOUT = 20000;
  static const RECEIVE_TIMEOUT = 20000;
}

class KAppLifeCycleEvents {
  static const NO_STATE_CHANGED = null;
  static const RESUMED = 0;
  static const INACTIVE = 1;
  static const PAUSED = 2;
}

class KNotificationTypes {}

class KPrefs {
  //Pref Constants
  static const TOKEN = 'token';
  static const IS_LOGGED_IN = 'is_logged_in';

  static const USER_ID = 'user_id';
  static const USER_EMAIL = 'user_email';
  static const USER_NAME = 'user_name';
  static const USER_COUNTRY_CODE = 'country_code';
}

class KReqHeaders {
  static const AUTHORIZATION = 'Authorization';
  static const DEVICE_TYPE = 'device_type';
  static const APP_VERSION = 'app_version';
  static const TIME_ZONE = 'tz';
}

class KApiResponseCodes {
  static const int STATUS_UNAUTHORISED_ACCESS = 401;
  static const int STATUS_SERVICE_UNAVAILABLE = 503;
  static const int STATUS_REQUEST_TIME_OUT = 408;
}

class KApiBase {
  static const BASE_URL = 'http://13.235.250.196/';
  static const API_VERSION = 'api/v1/';
}

class KApiEndPoints {
  /*Login Flow*/
  static const API_LOGIN = 'auth/login/';
  static const API_SEND_OTP = 'otp/send';
  static const API_RESEND_OTP = 'otp/resend';
}

class KDateFormats {
  static const DATE_FORMAT_1 = 'yyyy-MM-dd';
  static const DATE_FORMAT_2 = 'yyyy/MM/dd';
  static const DATE_FORMAT_3 = 'dd/MM/yyyy';
  static const DATE_FORMAT_4 = 'EEEE, d MMMM';
  static const DATE_FORMAT_5 = "d' 'MMM' '''yy";
  static const DATE_FORMAT_6 = 'dd MMM';
  static const DATE_FORMAT_7 = 'hh:mm a';
  static const DATE_FORMAT_8 = 'EEEE, MMMM d';
  static const DATE_FORMAT_9 = 'MMMM yyyy';
  static const DATE_FORMAT_10 = 'ddMMyy';
}

class SharedPrefsKeys {
  static const TOKEN = 'TOKEN';
  static const USER_LOGGED_IN = 'USER_LOGGED_IN';
  static const USER_TOKEN = 'USER_TOKEN';
}
