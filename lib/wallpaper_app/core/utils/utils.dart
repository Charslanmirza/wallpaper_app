import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import '../error/errors.dart';
import '../services/network_service.dart';
import 'package:flutter/services.dart';

DateTime get lastBirthDate =>
    DateTime.now().subtract(const Duration(days: 5475));

String maskedCardNumber(String last4) => last4.padLeft(12, '*');

// String cardBrandIcon(String brand) =>
//     brand == 'visa' ? AppAssets.visa_icon : AppAssets.master_card_icon;

// String cardBrandIcon(CreditCardType cardType) {
//   switch (cardType) {
//     case CreditCardType.visa:
//       return AppAssets.visa_icon;
//     case CreditCardType.mastercard:
//       return AppAssets.master_card_icon;
//   // Add cases for other card types if needed
//     default:
//       return ''; // Return a default icon if the card type is unknown
//   }
// }

String formatCardNumber(String cardNumber) {
  final formatted = cardNumber.replaceAllMapped(
    RegExp(r'^(\d{4})(\d{4})(\d{4})(\d{4})$'),
    (match) => '${match[1]} ${match[2]} ${match[3]} ${match[4]}',
  );
  return formatted;
}

final formatCurrency =
    NumberFormat.currency(name: "SGD ", locale: 'en_US', decimalDigits: 2);

String priceDisplay(total) {
  return formatCurrency.format(total);
}

final emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final trailingZeroRegExp = RegExp(r'([.]*0)(?!.*\d)');
final spaceRegExp = RegExp('[ ]');
final oneDecimal = RegExp(r'^\d+\.?\d*');
final onlyAlphabets = RegExp("[a-z A-Z]");
final manySpacesAsOne = RegExp(r"\s+");
final denySpaceFormatter = FilteringTextInputFormatter.deny(spaceRegExp);
final allowOnlyAlphaNumeric = RegExp("[0-9a-zA-Z]");
final phoneRegExp = RegExp(r'^\+?\d*');

/// Amount Calculator for Stripe
stripeAmountCalculator(String amount) {
  final calculatedAmount = (int.parse(amount)) * 100;
  return calculatedAmount.toString();
}

String getExtension(Uint8List bytes) {
  final mimeType = lookupMimeType('', headerBytes: bytes);
  return mimeType!.split('/').last;
}

DateFormat timeDateDayYear = DateFormat.jm().add_MMMEd().add_y();
DateFormat timeDateYear = DateFormat.jm().add_yMMMd();
DateFormat goodDateFormat = DateFormat.MMMMEEEEd();

DateFormat datePickerFormat = DateFormat('yyyy-MM-dd');

///If you want to keep the time format in 24-hour format,
///you can modify your expiryDateFormat object to use the
///H format specifier instead of the h specifier.
///The H specifier is used to represent the hour in a 24-hour format (0-23),
///whereas the h specifier is used to represent the hour in a 12-hour format (1-12).

DateFormat apiDateFormat = DateFormat('yyyy-MM-dd');

DateFormat dobFormat = DateFormat('dd-MM-yyyy');
DateFormat dmyFormat = DateFormat('dd-MM-yyyy');
DateFormat expiryDateFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
DateFormat couponDateFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
DateFormat cardExpiryFormat = DateFormat('MM/yyyy');
DateFormat voucherFormat =DateFormat('d MMMM,yyyy');
DateFormat finalApiDateFormat = DateFormat('dd-MM-yyyy');
DateFormat finalApiDateTimeFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
DateFormat notificationDateFormat = DateFormat('dd/MM');
String orderDateFormat(DateTime inputDate) {
  // final dateTime = DateTime.parse(inputDate); // Parse the input date string

  final dayFormat = DateFormat.EEEE(); // Format for the day (Tuesday)
  final timeFormat = DateFormat.jm(); // Format for the time (9:00 PM)
  final dateFormat = DateFormat.yMMMMd(); // Format for the date (9 May 2023)

  final day = dayFormat.format(inputDate);
  final time = timeFormat.format(inputDate);
  final date = dateFormat.format(inputDate);

  return '$day, $time, $date';
}
const int maxScrollExtent = 50;

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  if (kDebugMode) {
    pattern.allMatches(text).forEach((match) => log(match.group(0)!));
  }
}

/// Logs the error return from the repo implementation
// logError(String title, CustomError error) {
//   log("<------------------------------ Inside [$title] ------------------------------>");
//   FirebaseCrashlytics.instance
//       .recordError(error, StackTrace.fromString(error.stackTrace));
//   log(error.title, error: error);
//   log(error.message ?? '', error: error);
//
//   log(error.stackTrace);
// }

checkNetwork(NetworkInfo networkInfo) async {
  if (!(await networkInfo.isConnected)) {
    return Future.error(NetworkError());
  }
}

Future<void> showSnackDialog(context) async {
  return showDialog(
      context: context,
      builder: (context) => const SnackBar(content: Text('data')));
}

showAlertDialog(BuildContext context, String message, String description,
    Function() callBack) {
  AlertDialog alert = AlertDialog(
    title: Text(message),
    content: Text(description),
    actions: [
      TextButton(
        child: const Text("Cancel"),
        onPressed: () {
          Get.back();
        },
      ),
      TextButton(onPressed: callBack, child: const Text("Yes")),
    ],
  );

  // show the dialog
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

apiExceptionMapping(int statusCode) {
  // if (statusCode == 500) {
  //   return Future.error(ServerError());
  // }
  // if (statusCode == 404) {
  //   return Future.error(NotFoundException());
  // }
  // if (statusCode == 401) {
  //   return Future.error(AuthenticationError());
  // }
  if (statusCode != 200) {
    return Future.error(GeneralError());
  }
}

String multiplierString(int firstValue, double secondValue) =>
    '$firstValue X $secondValue';

String skuString(int? id) => 'SKU: ${id ?? 'Needs Update'}';

String totalString(String? currency) {
  return 'Total(${currency ?? 'SGD '})';
}

String totalTax(String? currency) {
  return 'Tax(${currency ?? 'SGD '})';
}

String totalPrice(String? symbol, double? price) {
  return '${symbol ?? 'S\$'} ${price ?? 0.0}';
}
String formatOutgoingTransaction(double amount)=> '-S\$${amount.toStringAsFixed(2)}';
String formatIncomingTransaction(double amount)=> '+S\$${amount.toStringAsFixed(2)}';
String formatGeneralBalance(double amount)=> 'S\$ ${amount.toStringAsFixed(2)}';
String formatPOName(int value) => 'P${value.toString().padLeft(5, '0')}';

String formatITName(int value) => 'WH/INT/${value.toString().padLeft(5, '0')}';

const int delayForListChange = 300;

const TextInputType quantityKeyBoardType =
    TextInputType.numberWithOptions(signed: true);

String getFileWithError(String stackTrace) {
  try {
    String line = stackTrace.trim().split("\n")[0];
    return line.split(':')[1].split('/').last;
  } catch (e) {
    return "Not located";
  }
}

logAPI(String url) {
  if (kDebugMode) {
    log('API');
    log(url);
  }
}

logResponse(dynamic response) {
  if (kDebugMode) {
    log('Response');
    log(response.toString());
  }
}

logBody(dynamic body) {
  if (kDebugMode) {
    log('Body');
    log(body.toString());
  }
}

customLog({required String url, dynamic response, dynamic body}) {
  logAPI(url);
  if (body != null) {
    logBody(body);
  }

  logResponse(response);
}

bool shouldShowBackButton(BuildContext context) {
  final route = ModalRoute.of(context);
  if (route != null) {
    if (route is PageRoute && route.fullscreenDialog) {
      // Exclude fullscreen dialogs from showing the back button
      return false;
    }
    if (route.isFirst) {
      // Exclude the last screen in the bottom navigation stack
      return false;
    }
  }
  return true;
}
