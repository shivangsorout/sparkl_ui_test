import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class OverlayWidget extends StatelessWidget {
  final Widget child;
  const OverlayWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      padding: EdgeInsets.zero,
      strokeWidth: 3,
      borderType: BorderType.RRect,
      radius: Radius.circular(40),
      color: Color(0xfff9d558),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
          child: Container(
            color: Colors.white.withAlpha((255 * 0.7).round()),
            padding: EdgeInsets.all(8),
            child: child,
          ),
        ),
      ),
    );
  }
}
