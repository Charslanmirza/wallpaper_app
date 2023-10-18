
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wallpaper_app/wallpaper_app/core/popups/widgets/image_choice.dart';
import 'package:wallpaper_app/wallpaper_app/core/widgets/image_viewer.dart';

import '../constants/app_literals.dart';
import '../error/errors.dart';
import '../styles/colors.dart';
import '../utils/utils.dart';
import '../widgets/loading_tap_detector.dart';
import 'show_snackbar.dart';
import 'widgets/choice_dialog.dart';
import 'widgets/payment_success_dialog.dart';

// Future<void> showErrorDialog(BuildContext context, CustomError? error,
//     {Function()? onPressed}) {
//   return showDialog(
//       context: context,
//       barrierDismissible: false,
//       useSafeArea: true,
//       builder: (buildContext) => ChoiceDialog(
//           title: error!.title,
//           message:
//               '${error.message} \n\n File: ${getFileWithError(error.stackTrace)}',
//           firstChoice: AppLiterals.okButtonText,
//           firstOnPressed: () {
//             if (onPressed != null) {
//               onPressed();
//             } else {
//               Navigator.pop(context);
//             }
//           }));
// }

Future<void> getErrorDialog(CustomError? error,
    {String buttonText = AppLiterals.okButtonText, Function()? onPressed}) {
  removeAllGetSnackBars();
  return Get.dialog(
      ChoiceDialog(
          title: error!.title,
          message:
              '${error.message} ${kDebugMode ? '\n\n File: ${getFileWithError(error.stackTrace)}' : ''}',
          firstChoice: buttonText,
          firstOnPressed: () {
            if (onPressed != null) {
              onPressed();
            } else {
              Get.back();
            }
          }),
      barrierDismissible: true,
      useSafeArea: true);
}

Future<void> getMessageDialog(
    {required String title, required String message, Function()? onPressed}) {
  removeAllGetSnackBars();
  return Get.dialog(
      ChoiceDialog(
          title: title,
          message: message,
          firstChoice: AppLiterals.okButtonText,
          firstOnPressed: () {
            if (onPressed != null) {
              onPressed();
            } else {
              Get.back();
            }
          }),
      barrierDismissible: false,
      useSafeArea: true);
}
//
// Future<void> showCreatedDialog(BuildContext context,
//     {required EntityType entityType,
//     required String name,
//     required int id,
//     Function()? onPressed}) {
//   return showDialog(
//       context: context,
//       barrierDismissible: false,
//       useSafeArea: true,
//       builder: (buildContext) => ChoiceDialog(
//           title: AppLiterals.successTitle,
//           message: '${entityType.name} created!\n name: $name\n id: $id',
//           firstChoice: AppLiterals.okButtonText,
//           firstOnPressed: () {
//             if (onPressed != null) {
//               onPressed();
//             } else {
//               Navigator.of(context)
//                 ..pop()
//                 ..pop();
//             }
//           }));
// }

Future<void> showPaymentResultDialog(PaymentResult result) {
  removeAllGetSnackBars();

  Future.delayed(const Duration(seconds: 1), () async {
    Get.back();
  });
  return Get.dialog(
    PaymentResultDialog(
      paymentResult: result,
    ),
    barrierDismissible: false,
  );
}

/// Logic implies to wherever this dialog is used and the result value is used.
/// In this case, the condition result == null checks if result is null. If it is null, the first condition is true,
///  and the second condition !result won't be evaluated. The return statement will be executed, and the function will exit.
/// If result is not null, the first condition result == null is false, and the second condition !result will be evaluated.
/// The ! operator will convert result to its corresponding boolean value and negate it. If result is true,
/// !result will be false, and if result is false, !result will be true. If the second condition is true,
/// the return statement will be executed, and the function will exit.
Future<bool?> getChoiceDialog(
    String title,
    String message,
    IconData positiveIcon,
    String positiveChoice,
    IconData negativeIcon,
    String negativeChoice) {
  removeAllGetSnackBars();
  return Get.dialog(ChoiceDialog(
      firstChoice: positiveChoice,
      secondChoice: negativeChoice,
      message: message,
      title: title,
      firstOnPressed: () => Get.back(result: true),
      secondOnPressed: () => Get.back(result: false)));
}

Future<bool?> loginAsGuestDialog(
    String title,
    String message,
    IconData positiveIcon,
    String positiveChoice,
    IconData negativeIcon,
    String negativeChoice,
    Function() callBack) {
  return Get.dialog(ChoiceDialog(
      firstChoice: positiveChoice,
      secondChoice: negativeChoice,
      message: message,
      title: title,
      firstOnPressed: callBack,
      secondOnPressed: () => Get.back(result: false)));
}

Future<void> getImageDialog(String imageUrl) {
  return Get.dialog(
    ImageViewer(
      imageUrl: imageUrl,
    ),
    barrierColor: AppColors.imageViewerBarrierColor,
  );
}

Future<ImageSource?> getImageChoiceDialog() {
  return Get.dialog(const ImageChoiceDialog());
}

Future showLoading(LoadingTapType loadingTapType) {
  return Get.dialog(
      LoadingTapDetector(
          loadingTapType: loadingTapType,
          shouldAddCallBack: true,
          isLoading: true,
          child: const SizedBox()),
      barrierColor: Colors.transparent,
      barrierDismissible: false);
}

Future<bool?> discountTypeWarning() async {
  return await getChoiceDialog(
      'Switch Discount',
      'If you change discount type, the total amount will be recalculated',
      Icons.done,
      'Confirm Change',
      Icons.change_circle_outlined,
      'Revert');
}
