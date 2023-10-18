import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors {
  static final int primaryColorHex = 0xffFFFFFF;
  static final Color primaryColor = Color(primaryColorHex);
  static final Color accentColor = Color(0xfffffff);
  static final Color containerColor = Color(0xfffffff);
  static const Color blackColor = Colors.black;
  static const Color whiteColor = Colors.white;
  static const Color redAccent = Color(0xffB82713);
  static const Color whiteAccent = Color(0xffF2F2F2);

  static final MaterialColor primarySwatch = MaterialColor(primaryColorHex, {
    50: primaryColor,
    100: primaryColor,
    200: primaryColor,
    300: primaryColor,
    400: primaryColor,
    500: primaryColor,
    600: primaryColor,
    700: primaryColor,
    800: primaryColor,
    900: primaryColor,
  });

  static Color imageViewerBarrierColor = Colors.grey.withOpacity(0.6);
  static Color shimmerHighlightColor = Colors.grey[100]!;
}
