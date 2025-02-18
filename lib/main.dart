import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sparkl_ui_test/custom_widgets/circular_video_widget.dart';
import 'package:sparkl_ui_test/custom_widgets/logo_widget.dart';
import 'package:sparkl_ui_test/custom_widgets/next_button.dart';
import 'package:sparkl_ui_test/custom_widgets/overlay_widget.dart';
import 'package:sparkl_ui_test/custom_widgets/stacked_cards.dart';
import 'package:sparkl_ui_test/custom_widgets/text_widgets.dart';
import 'package:sparkl_ui_test/custom_widgets/video_widget.dart';
import 'package:sparkl_ui_test/extensions/build_context.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

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
  int _currentPage = 0;

  nextOnPress() {
    if (_currentPage < 2) {
      setState(() {
        _currentPage++;
      });
    }
  }

  previousOnPress() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
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
            Padding(
              padding: EdgeInsets.only(top: context.mqSize.height * 0.021),
              child: pages[_currentPage],
            ),

            // Next Button
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.symmetric(
                horizontal: context.mqSize.width * 0.048,
                vertical: context.mqSize.height * 0.021,
              ),
              child: Row(
                children: [
                  Visibility(
                    visible: _currentPage >= 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: context.mqSize.width * 0.036,
                      ),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: previousOnPress,
                        child: CircularStepProgressIndicator(
                          totalSteps: 3,
                          currentStep: _currentPage + 1,
                          selectedColor: Color(0xfffbd044),
                          unselectedColor: Color(0xffe9dcc7),
                          width: context.mqSize.height * 0.057,
                          height: context.mqSize.height * 0.057,
                          stepSize: 5,
                          padding: 0.1,
                          child: Icon(Icons.arrow_back, size: 25),
                        ),
                      ),
                    ),
                  ),
                  NextButton(
                    buttonText: _currentPage == 2 ? 'Get Started' : 'Next',
                    onPressed: nextOnPress,
                  ),
                ],
              ),
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
                      CircularVideoWidget(
                        asset: 'assets/studentvideo.mp4',
                        dimension: context.mqSize.height * 0.26,
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.mqSize.width * 0.041),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LogoWidget(
            height: context.mqSize.height * 0.032,
            alignment: Alignment.topLeft,
          ),
          SizedBox(height: context.mqSize.height * 0.03),
          TitleText('1-on-1 Live Classes'),
          SubtitleText(text: ' Learning customized for every student'),

          // Teacher's Video
          Align(
            alignment: Alignment.center,
            child: Container(
              height: context.mqSize.height * 0.097,
              width: context.mqSize.width * 0.34,
              margin: EdgeInsets.only(top: context.mqSize.height * 0.06),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    offset: Offset(3.0, 4.0),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  height: context.mqSize.height * 0.097,
                  width: context.mqSize.width * 0.34,
                  child: VideoWidget(asset: 'assets/teachervideo.mp4'),
                ),
              ),
            ),
          ),

          // Stacked stack cards with student video
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: context.mqSize.height * 0.037),
                child: StackedCards(),
              ),
              Positioned(
                bottom: 0,
                child: CircularVideoWidget(
                  dimension: context.mqSize.height * 0.09,
                  asset: 'assets/studentvideo.mp4',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget pageThree(BuildContext context) {
    return Column();
  }
}
