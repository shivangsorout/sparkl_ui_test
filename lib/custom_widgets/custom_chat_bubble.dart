import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:sparkl_ui_test/custom_widgets/circular_video_widget.dart';
import 'package:sparkl_ui_test/extensions/build_context.dart';

class CustomChatBubble extends StatelessWidget {
  final double rightPadding;
  final String text;
  final bool isTeacher;
  final bool showVideo;
  final Animation<double> sizeAnimation;
  const CustomChatBubble({
    super.key,
    this.rightPadding = 0.073,
    required this.text,
    required this.isTeacher,
    this.showVideo = false,
    required this.sizeAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: sizeAnimation,
      builder: (context, child) {
        return Stack(
          alignment:
              isTeacher
                  ? AlignmentDirectional.topStart
                  : AlignmentDirectional.topEnd,
          children: [
            Padding(
              padding:
                  isTeacher
                      ? EdgeInsets.only(
                        top: context.mqSize.height * 0.0285,
                        left: context.mqSize.width * 0.0194,
                      )
                      : EdgeInsets.only(
                        top: context.mqSize.height * 0.0205,
                        right: context.mqSize.width * 0.044,
                      ),
              child: Transform.scale(
                scale: sizeAnimation.value,
                child: ChatBubble(
                  alignment: isTeacher ? Alignment.topLeft : Alignment.topRight,
                  clipper: ChatBubbleClipper3(
                    type:
                        isTeacher
                            ? BubbleType.receiverBubble
                            : BubbleType.sendBubble,
                    radius: 10,
                  ),
                  backGroundColor: isTeacher ? Color(0xffffe38d) : Colors.white,
                  padding: EdgeInsets.only(
                    top: context.mqSize.height * 0.0125,
                    bottom: context.mqSize.height * 0.0125,
                    left: (isTeacher ? 0.061 : 0.036) * context.mqSize.width,
                    right: rightPadding * context.mqSize.width,
                  ),
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 0.023 * context.mqSize.height),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: showVideo,
              child: CircularVideoWidget(
                dimension: 0.045 * context.mqSize.height,
                asset: 'assets/${isTeacher ? 'teacher' : 'student'}video.mp4',
              ),
            ),
          ],
        );
      },
    );
  }
}
