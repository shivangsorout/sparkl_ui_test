import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sparkl_ui_test/custom_widgets/logo_widget.dart';
import 'package:sparkl_ui_test/custom_widgets/next_button.dart';
import 'package:sparkl_ui_test/custom_widgets/overlay_widget.dart';
import 'package:sparkl_ui_test/custom_widgets/text_widgets.dart';
import 'package:sparkl_ui_test/custom_widgets/video_widget.dart';
import 'package:sparkl_ui_test/extensions/build_context.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          surface: Color(0xfffffaea),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;

  buttonOnPress() {
    if (currentPage < 2) {
      setState(() {
        currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      pageOne(context),
      pageTwo(context),
      pageThree(context),
    ];
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            pages[currentPage],

            // Next Button
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.symmetric(
                horizontal: context.mqSize.width * 0.048,
                vertical: context.mqSize.height * 0.021,
              ),
              child: NextButton(onPressed: buttonOnPress),
            ),
          ],
        ),
      ),
    );
  }

  Widget pageOne(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(height: context.mqSize.height * 0.021),
        LogoWidget(
          height: context.mqSize.height * 0.045,
          alignment: Alignment.center,
        ),
        SizedBox(height: context.mqSize.height * 0.03),
        TitleText('Learning Made\nPersonal', textAlign: TextAlign.center),
        SubtitleText(text: 'A Program designed just for YOU!'),
        SizedBox(height: context.mqSize.height * 0.1),

        // Middle video with overlays
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background lottie animation
                      Transform.scale(
                        scale: 1.4,
                        child: Lottie.asset(
                          'assets/sparkl_shape_shift_lottie.json',
                        ),
                      ),

                      // Circular student video
                      ClipOval(
                        child: SizedBox.square(
                          dimension: context.mqSize.height * 0.26,
                          child: VideoWidget(asset: 'assets/studentvideo.mp4'),
                        ),
                      ),

                      // Circular border
                      Container(
                        width: context.mqSize.height * 0.26 + 23,
                        height: context.mqSize.height * 0.26 + 23,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xfff9d558),
                            width: 2,
                          ),
                        ),
                      ),

                      // Overlays
                      Positioned(
                        top: context.mqSize.height * 0.034,
                        right: context.mqSize.width * 0.073,
                        child: OverlayWidget(
                          child: ItalicTextWidget(text: 'Holistic Well-Being'),
                        ),
                      ),
                      Positioned(
                        bottom: context.mqSize.height * 0.057,
                        right: context.mqSize.width * 0.109,
                        child: OverlayWidget(
                          child: ItalicTextWidget(text: 'Personalised'),
                        ),
                      ),
                      Positioned(
                        bottom: context.mqSize.height * 0.0114,
                        left: context.mqSize.width * 0.122,
                        child: OverlayWidget(
                          child: ItalicTextWidget(text: 'Doubt Clarification'),
                        ),
                      ),
                      Positioned(
                        bottom: context.mqSize.height * 0.091,
                        left: context.mqSize.width * 0.16,
                        child: OverlayWidget(
                          child: SizedBox.square(
                            dimension: context.mqSize.height * 0.031,
                            child: Image.asset('assets/pre_read_selected.png'),
                          ),
                        ),
                      ),
                      Positioned(
                        top: context.mqSize.height * 0.0114,
                        left: context.mqSize.width * 0.22,
                        child: OverlayWidget(
                          child: SizedBox.square(
                            dimension: context.mqSize.height * 0.04,
                            child: Image.asset('assets/blue_book.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Emoji Overlay
            Padding(
              padding: EdgeInsets.only(
                top: context.mqSize.height * 0.028,
                left: context.mqSize.width * 0.195,
              ),
              child: OverlayWidget(
                child: SizedBox.square(
                  dimension: context.mqSize.height * 0.034,
                  child: Image.asset('assets/emoji.png'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget pageTwo(BuildContext context) {
    return Column();
  }

  Widget pageThree(BuildContext context) {
    return Column();
  }
}
