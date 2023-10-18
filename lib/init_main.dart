import 'dart:ui';

import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'wallpaper_app/core/services/network_service.dart';

initMain() {
  Get.lazyPut<NetworkInfo>(
      () => NetworkInfoImpl(Get.find<InternetConnectionCheckerPlus>()),
      fenix: true);

  Get.lazyPut<Dio>(() => Dio(), fenix: true);

  Get.lazyPut<InternetConnectionCheckerPlus>(
      () => InternetConnectionCheckerPlus(),
      fenix: true);
}
