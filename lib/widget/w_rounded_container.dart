import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double radius;
  final Color? backgroundColor;
  final EdgeInsets? margin;
  final Color borderColor;
  final double borderWidth;
  final BorderRadiusGeometry? radiusOnly;

  const RoundedContainer(
      {super.key,
      required this.child,
      this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      this.radius = 15,
      this.radiusOnly,
      this.borderColor = Colors.white,
      this.margin,
      this.borderWidth = 0,
      this.backgroundColor = Colors.white54});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor, width: borderWidth),
          borderRadius: radiusOnly ?? BorderRadius.circular(radius)),
      child: child,
    );
  }
}
