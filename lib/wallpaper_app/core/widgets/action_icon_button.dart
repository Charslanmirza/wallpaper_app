import 'package:flutter/material.dart';

import '../enums.dart';
import 'small_progress_indicator.dart';

class ActionIconButton extends StatefulWidget {
  const ActionIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.color,
    this.size,
  }) : super(key: key);

  final IconData icon;
  final Future Function()? onPressed;
  final Color color;
  final double? size;

  @override
  State<ActionIconButton> createState() => _ActionIconButtonState();
}

class _ActionIconButtonState extends State<ActionIconButton> {
  LoadingState loadingState = LoadingState.loaded;

  @override
  Widget build(BuildContext context) {
    return loadingState == LoadingState.loading
        ? Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
            child: SmallProgressIndicator(
              color: widget.color,
            ),
          )
        : IconButton(
            onPressed: widget.onPressed != null
                ? () async {
                    setState(() {
                      loadingState = LoadingState.loading;
                    });
                    await widget.onPressed!();

                    setState(() {
                      loadingState = LoadingState.loaded;
                    });
                  }
                : null,
            icon: Icon(
              widget.icon,
              color: widget.color,
              size: widget.size,
            ),
          );
  }
}
