import 'package:flutter/material.dart';

import '../enums.dart';
import '../styles/colors.dart';

/// Widget that renders a [Button] with transparent or fill background
/// Exposes [onPressed] function
class ButtonWidget extends StatefulWidget {
  final Future Function()? onPressed;
  final String text;
  final TextStyle? textStyle;
  final Color? color;
  final EdgeInsetsGeometry margin;
  final bool isLoading;
  final ButtonType buttonType;
  final Icon? icon;
  final double height;
  final double? width;
  final double radius;
  final bool expand;

  const ButtonWidget(
      {Key? key,
        this.onPressed,
        required this.text,
        this.textStyle,
        this.color,
        this.margin = EdgeInsets.zero,
        required this.buttonType,
        this.isLoading = false,
        this.icon,
        this.width,
        this.expand = true,
        this.radius = 25.0,
        this.height = 40.0})
      : super(key: key);

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  LoadingState buttonLoadingState = LoadingState.loaded;

  bool get isButtonLoadingState => buttonLoadingState == LoadingState.loading;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0),
        backgroundColor: MaterialStateProperty.all(getBackgroundColor()),
        foregroundColor: MaterialStateProperty.all(getForegroundColor()),
        side: MaterialStateProperty.all(
          BorderSide(
              color: widget.color ?? Theme.of(context).colorScheme.primary),
        ),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(widget.radius),
        )));

    return Container(
        height: widget.height,
        margin: widget.margin,
        width: widget.width,
        //   width: width ?? (expand ? double.infinity : null),
        child: ElevatedButton.icon(
            icon: widget.icon ?? const SizedBox(),
            style: buttonStyle,
            onPressed: () async {
              setState(() {
                buttonLoadingState = LoadingState.loading;
              });

              await widget.onPressed!();

              setState(() {
                buttonLoadingState = LoadingState.loaded;
              });
            },
            label: isButtonLoadingState
                ? SizedBox(
              height: 30.0,
              width: 30.0,
              child: CircularProgressIndicator(
                color: getProgressIndicatorColor(),
              ),
            )
                : Text(
              widget.text,
              style: widget.textStyle,
              textAlign: TextAlign.center,
            )));
  }

  getForegroundColor() {
    return widget.buttonType == ButtonType.fill
        ? Colors.white
        : widget.color ?? Colors.black;
  }

  getBackgroundColor() {
    return widget.buttonType == ButtonType.transparent
        ? Colors.transparent
        : widget.buttonType == ButtonType.white
        ? Colors.white
        : widget.buttonType == ButtonType.fill
        ? widget.color ?? Theme.of(context).colorScheme.primary
        : Colors.white;
  }

  getProgressIndicatorColor() {
    return widget.buttonType == ButtonType.fill
        ? Colors.white
        : (widget.color ?? AppColors.primaryColor);
  }
}

enum ButtonType { transparent, fill, white }

// class ButtonWidget extends StatelessWidget {
//   final Function()? onPressed;
//   final String text;
//   final TextStyle? textStyle;
//   final Color? color;
//   final EdgeInsetsGeometry margin;
//   final bool isLoading;
//   final ButtonType buttonType;
//   final Icon? icon;
//   final double height;
//   final double? width;
//   final double radius;
//   final bool expand;
//
//   const ButtonWidget(
//       {Key? key,
//       this.onPressed,
//       required this.text,
//       this.textStyle,
//       this.color,
//       this.margin = EdgeInsets.zero,
//       required this.buttonType,
//       this.isLoading = false,
//       this.icon,
//       this.width,
//       this.expand = true,
//       this.radius = 12.0,
//       this.height = 50.0})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final buttonStyle = ButtonStyle(
//         elevation: MaterialStateProperty.all<double>(0),
//         backgroundColor: MaterialStateProperty.all(getBackgroundColor()),
//         foregroundColor: MaterialStateProperty.all(getForegroundColor()),
//         side: MaterialStateProperty.all(
//           BorderSide(color: color ?? Theme.of(context).colorScheme.primary),
//         ),
//         padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0)),
//         shape: MaterialStateProperty.all(RoundedRectangleBorder(
//           side:  BorderSide(color: AppColors.primaryColor),
//           borderRadius: BorderRadius.circular(radius),
//         )));
//
//     return Container(
//         height: height,
//         margin: margin,
//         width: width,
//         //   width: width ?? (expand ? double.infinity : null),
//         child: ElevatedButton.icon(
//           icon: icon ?? const SizedBox(),
//           style: buttonStyle,
//           onPressed: isLoading ? null : onPressed,
//           label: !isLoading
//               ? Text(
//                   text,
//                   style: textStyle,
//                   textAlign: TextAlign.center,
//                 )
//               : SizedBox(
//                   height: 30.0,
//                   width: 30.0,
//                   child: CircularProgressIndicator(
//                     color: getProgressIndicatorColor(),
//                   ),
//                 ),
//         ));
//   }
//
//   getForegroundColor() {
//     return buttonType == ButtonType.fill ? Colors.white : color ?? Colors.black;
//   }
//
//   getBackgroundColor() {
//     return buttonType == ButtonType.transparent
//         ? Colors.transparent
//         : buttonType == ButtonType.white
//             ? Colors.white
//             : buttonType == ButtonType.fill
//                 ? color ?? AppColors.primaryColor
//                 : Colors.white;
//   }
//
//   getProgressIndicatorColor() {
//     return buttonType == ButtonType.fill
//         ? Colors.white
//         : (color ?? AppColors.primaryColor);
//   }
// }
//
// class CardButton extends StatelessWidget {
//   const CardButton(
//       {Key? key,
//       required this.icon,
//       required this.text,
//       required this.onPressed})
//       : super(key: key);
//
//   final IconData icon;
//   final String text;
//   final Function() onPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     return ButtonWidget(
//       expand: false,
//       text: text,
//       buttonType: ButtonType.transparent,
//       radius: 120.0,
//       height: 413.0,
//       onPressed: onPressed,
//     );
//   }
// }
//
