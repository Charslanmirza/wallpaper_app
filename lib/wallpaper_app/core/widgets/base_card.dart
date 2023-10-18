import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'custom_shimmer_widget.dart';

/// Implements the basic bordered design of the cards used in the app.
/// Can also display [Shimmer] is [isLoading] is set to true.
class BaseCard extends StatelessWidget {
  const BaseCard(
      {Key? key,
        this.onTap,
        this.child,
        this.height,
        this.width,
        this.isLoading = false})
      : super(key: key);

  final double? height;
  final bool isLoading;
  final Function()? onTap;
  final Widget? child;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Container(
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            // Adding shimmer here instead of adding it to the [child], because [padding] is for
            // content only.
            child: isLoading
                ? const CustomShimmer(margin: EdgeInsets.zero)
                : child,
          )),
    );
  }
}
