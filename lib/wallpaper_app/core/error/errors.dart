import 'package:flutter/cupertino.dart';

import '../constants/app_literals.dart';
import '../styles/icons.dart';

class CustomError {
  IconData iconData;
  String title;
  String? message;
  String stackTrace;

  CustomError(
      {required this.iconData,
      required this.title,
      required this.message,
      required this.stackTrace});
}

class GeneralError extends CustomError {
  GeneralError(
      {super.iconData = AppIcons.iconError,
      super.title = AppLiterals.defaultGeneralErrorTitle,
      super.message = AppLiterals.defaultGeneralErrorMessage,
      super.stackTrace = AppLiterals.emptyString});
}

///This error is thrown when user enters in application and
///if client id is expired,disabled by admin,or have'nt paid,
class ClientError extends CustomError {
  ClientError(
      {super.iconData = AppIcons.iconServerError,
      super.title = AppLiterals.defaultClientErrorTitle,
      super.message = AppLiterals.defaultClientErrorMessage,
      super.stackTrace = AppLiterals.emptyString});
}

class NetworkError extends CustomError {
  NetworkError(
      {super.iconData = AppIcons.iconNoInternet,
      super.title = AppLiterals.defaultNetworkErrorTitle,
      super.message = AppLiterals.defaultNetworkErrorMessage,
      super.stackTrace = AppLiterals.emptyString});
}
