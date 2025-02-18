import 'package:flutter/material.dart';

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
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
