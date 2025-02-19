import 'package:flutter/material.dart';
import 'package:sparkl_ui_test/extensions/build_context.dart';

class OverlaysHolderWidget extends StatelessWidget {
  final List<Widget> children;
  const OverlaysHolderWidget({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              SizedBox(height: context.mqSize.height * 0.29),
              ...children,
            ],
          ),
        ),
      ],
    );
  }
}
