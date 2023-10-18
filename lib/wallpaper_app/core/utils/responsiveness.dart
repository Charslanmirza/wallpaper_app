import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

getTextStyle(BuildContext context) {
  return getValueForScreenType(
      context: context,
      mobile: Theme.of(context).textTheme.headlineSmall,
      tablet: Theme.of(context).textTheme.headlineMedium,
      desktop: Theme.of(context).textTheme.headlineLarge);
}
