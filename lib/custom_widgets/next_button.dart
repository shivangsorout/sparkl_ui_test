import 'package:flutter/material.dart';
import 'package:sparkl_ui_test/extensions/build_context.dart';

class NextButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressed;

  const NextButton({super.key, this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        height: 48,
        color: Color(0xfffbd044),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: context.mqSize.height * 0.0194,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
