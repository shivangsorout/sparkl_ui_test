import 'package:flutter/material.dart';
import 'package:sparkl_ui_test/extensions/build_context.dart';

class StackedCards extends StatelessWidget {
  const StackedCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: context.mqSize.width * 0.11,
            right: context.mqSize.width * 0.11,
          ),
          child: Image.asset('assets/stack_card.png'),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: context.mqSize.height * 0.02,
            left: context.mqSize.width * 0.073,
            right: context.mqSize.width * 0.073,
          ),
          child: Image.asset('assets/stack_card.png'),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: context.mqSize.height * 0.04,
            left: context.mqSize.width * 0.036,
            right: context.mqSize.width * 0.036,
          ),
          child: Image.asset('assets/stack_card.png'),
        ),
        Padding(
          padding: EdgeInsets.only(top: context.mqSize.height * 0.06),
          child: Image.asset('assets/stack_card.png'),
        ),
      ],
    );
  }
}
