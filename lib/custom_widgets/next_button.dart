import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final void Function()? onPressed;

  const NextButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MaterialButton(
            onPressed: onPressed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            height: 48,
            color: Color(0xfffbd044),
            child: Text(
              'Next',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
