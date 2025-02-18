import 'package:flutter/material.dart';
import 'package:sparkl_ui_test/extensions/build_context.dart';

class SubtitleText extends StatelessWidget {
  final String text;
  const SubtitleText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: context.mqSize.height * 0.023,
        fontWeight: FontWeight.w500,
        color: Color(0xff525352),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  const TitleText(this.text, {super.key, this.textAlign = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: context.mqSize.height * 0.045,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class ItalicTextWidget extends StatelessWidget {
  final String text;
  const ItalicTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
