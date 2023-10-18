import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String? text;
  final double size;
  final FontWeight fontWeight;
  final Color? colorText;
  // final Function()? onTap;
  final int? maxLines;
  final String? fontFamily;
  final FontStyle fontStyle;
  final Widget? buttonIcon;
  final TextAlign textAlign;
  final bool isLoading;
  final AlignmentGeometry? alignment;
  const CustomTextWidget(
      {super.key,
      this.text,
      this.alignment,
      this.buttonIcon,
      this.size = 14,
      this.fontWeight = FontWeight.normal,
      this.colorText,
      // this.onTap,
      this.isLoading = false,
      this.fontStyle = FontStyle.normal,
      this.maxLines = 10000,
      this.fontFamily,
      this.textAlign = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: alignment,
        child: Text(
          text ?? '',
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontStyle: fontStyle,
              fontSize: size,
              fontFamily: fontFamily,
              fontWeight: fontWeight,
              color: colorText,
              letterSpacing: 0.5),
        ));
  }
}
