
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final String? Function(String?)? validator; // New validator property
  final Widget? suffixIcon;
  final bool? obscureText;
  final int? maxLength;
  final int? maxLines;
  final void Function(String)? onChanged; // New onChanged property
  final String? initialValue;
  // final TextInputAction? inputType;
  const CustomTextField({
    this.labelText,
    this.hintText,
    this.validator,
    this.maxLength,
    this.suffixIcon,
    this.obscureText,
    this.initialValue,
    this.maxLines,
    // this.inputType,
    this.onChanged, // Pass the onChanged through the constructor
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // textInputAction: inputType,
      keyboardType: TextInputType.number,
      maxLength: maxLength,
      maxLines: obscureText == true ? 1 : maxLines,
      initialValue: initialValue,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: Theme.of(context).textTheme.bodyLarge,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      onChanged: onChanged, // Assign the onChanged from the widget's property
    );
  }
}
