import 'package:flutter/material.dart';
import 'package:sparkl_ui_test/extensions/build_context.dart';

class StackedCards extends StatelessWidget {
  final List<Animation<Offset>> position;
  const StackedCards({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Last Card
        Padding(
          padding: EdgeInsets.only(
            left: context.mqSize.width * 0.11,
            right: context.mqSize.width * 0.11,
          ),
          child: SlideTransition(
            position: position[3],
            child: Image.asset('assets/stack_card.png'),
          ),
        ),
        // Third Card
        Padding(
          padding: EdgeInsets.only(
            top: context.mqSize.height * 0.02,
            left: context.mqSize.width * 0.073,
            right: context.mqSize.width * 0.073,
          ),
          child: SlideTransition(
            position: position[2],
            child: Image.asset('assets/stack_card.png'),
          ),
        ),
        // Second Card
        Padding(
          padding: EdgeInsets.only(
            top: context.mqSize.height * 0.04,
            left: context.mqSize.width * 0.036,
            right: context.mqSize.width * 0.036,
          ),
          child: SlideTransition(
            position: position[1],
            child: Image.asset('assets/stack_card.png'),
          ),
        ),
        // Top Card
        Padding(
          padding: EdgeInsets.only(top: context.mqSize.height * 0.06),
          child: SlideTransition(
            position: position[0],
            child: Image.asset('assets/stack_card.png'),
          ),
        ),
      ],
    );
  }
}
