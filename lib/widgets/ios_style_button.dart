import 'package:flutter/cupertino.dart';

class IosStyleButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final double pressedOpacity;

  const IosStyleButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.pressedOpacity = 0.4,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: padding,
      borderRadius: borderRadius,
      color: backgroundColor,
      pressedOpacity: pressedOpacity,
      child: child,
    );
  }
}
