import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:flutter/material.dart';

import '../popups/show_snackbar.dart';

enum LoadingTapType {
  cartSave(message: "Saving cart, please wait..."),
  profile(message: "Saving Profile, please wait..."),
  deleteAccount(message: "Deleting account, please wait..."),
  cardSave(message: "Saving card, please wait..."),
  deposit(message: "Depositing money, please wait..."),
  auth(message: "Wait! Authentication is Being Done."),
  phoneAuth(message: "Wait! Authentication is Being Done."),
  deleteCard(message: "Wait! Card is being deleted..."),
  forgotPassword(message: "Wait! Authentication is Being Done."),
  setPassword(message: "Setting Password, please wait..."),
  signupAuth(message: "Wait! Authentication is Being Done."),
  saveAddress(message: "Saving Address, please wait..."),
  getAddress(message: "Getting Address, please wait..."),
  setAddress(message: "Setting Address, please wait..."),
  payment(message: "Payment in  Process, please wait..."),
  redeemVoucher(message: "Redeeming Voucher, please wait..."),
  selectVoucher(message: "Selecting voucher, please wait..."),
  appointments(message: "Loading Appointments, please wait...");

  const LoadingTapType({required this.message});

  final String message;
}

/// This widget is used on top of a screen, where loading
/// has to be displayed either on user action, or for loading
/// data from an API.
/// This widget absorbs user's tap based on the value of [isLoading],
/// and displays relevant messages based on [loadingTapType].
/// Uses [ConditionalWillPopScope] to prevent user from removing
/// any screen when an process is underway.
///
class LoadingTapDetector extends StatelessWidget {
  const LoadingTapDetector(
      {Key? key,
      required this.child,
      required this.loadingTapType,
      this.isCreating = true,
      this.isDeleting = false,
      this.shouldAddCallBack = true,
      required this.isLoading})
      : super(key: key);
  final bool shouldAddCallBack;
  final bool? isDeleting;
  final bool isCreating;
  final bool isLoading;
  final Widget child;
  final LoadingTapType loadingTapType;

  @override
  Widget build(BuildContext context) {
    return ConditionalWillPopScope(
      onWillPop: () async => false,
      shouldAddCallback: shouldAddCallBack ? isLoading : false,
      child: GestureDetector(
        onTap: isLoading
            ? () {
                getSnackBarError(message: loadingTapType.message);
              }
            : null,
        child: AbsorbPointer(absorbing: isLoading, child: child),
      ),
    );
  }
}
