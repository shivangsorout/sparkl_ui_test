import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final AlignmentGeometry alignment;
  final double height;

  const LogoWidget({super.key, required this.alignment, required this.height});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Image.asset('assets/sparkl_logo.png', height: height),
    );
  }
}
