import 'package:flutter/material.dart';
import 'package:sparkl_ui_test/custom_widgets/video_widget.dart';

class CircularVideoWidget extends StatelessWidget {
  final double dimension;
  final String asset;
  const CircularVideoWidget({
    super.key,
    required this.dimension,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox.square(
        dimension: dimension,
        child: VideoWidget(asset: asset),
      ),
    );
  }
}
