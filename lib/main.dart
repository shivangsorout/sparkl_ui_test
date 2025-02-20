import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sparkl_ui_test/custom_widgets/background_animation.dart';
import 'package:sparkl_ui_test/custom_widgets/circular_video_widget.dart';
import 'package:sparkl_ui_test/custom_widgets/custom_chat_bubble.dart';
import 'package:sparkl_ui_test/custom_widgets/logo_widget.dart';
import 'package:sparkl_ui_test/custom_widgets/next_button.dart';
import 'package:sparkl_ui_test/custom_widgets/overlay_widget.dart';
import 'package:sparkl_ui_test/custom_widgets/overlays_holder_widget.dart';
import 'package:sparkl_ui_test/custom_widgets/stacked_cards.dart';
import 'package:sparkl_ui_test/custom_widgets/text_widgets.dart';
import 'package:sparkl_ui_test/custom_widgets/video_widget.dart';
import 'package:sparkl_ui_test/extensions/build_context.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

late List<CameraDescription> camerasList;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  camerasList = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _currentPage = 0;

  // For logo's animation
  late AnimationController _controller1;
  late Animation<double> _sizeAnimationC1;
  late Animation<Offset> _positionAnimationC1;

  // For Teacher's video animation
  late AnimationController _controller2;
  late Animation<Alignment> _positionAnimationC2;
  late Animation<double> _widthAnimationC2;
  late Animation<double> _heightAnimationC2;
  late Animation<double> _borderAnimationC2;
  late Animation<Offset> _shadowAnimationC2;

  // For Left Overlays animation
  late AnimationController _controller3;
  late Animation<Offset> _positionAnimationC3;

  // For Right Overlays animation
  late AnimationController _controller4;
  late Animation<Offset> _positionAnimationC4;

  // For Student's video animation
  late AnimationController _controller5;
  late Animation<Alignment> _positionAnimationC5;
  late Animation<double> _sizeAnimationC5;

  // For Stacked Cards animation
  late AnimationController _controller6;
  late List<Animation<Offset>> _positionAnimationC6;

  // For Chat Bubbles animation
  late AnimationController _controller7;
  late List<Animation<double>> _sizeAnimationC7;

  final PageController _pageController = PageController();
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    initializeAnimations();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _controller5.dispose();
    _controller6.dispose();
    _controller7.dispose();
    super.dispose();
  }

  // Initializing Animations
  initializeAnimations() {
    // // For Logo Animation
    _controller1 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    // Shrinking effect
    _sizeAnimationC1 = Tween<double>(
      begin: 1.0,
      end: 0.713,
    ).animate(CurvedAnimation(parent: _controller1, curve: Curves.easeInOut));

    // Horizontal movement with bounce
    _positionAnimationC1 = TweenSequence<Offset>([
      TweenSequenceItem<Offset>(
        tween: Tween<Offset>(begin: Offset(0, 0), end: Offset(-150, -5)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(begin: Offset(-145, -10), end: Offset(-135, -10)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(begin: Offset(-135, -10), end: Offset(-125, -10)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(begin: Offset(-125, -10), end: Offset(-135, -10)),
        weight: 20,
      ),
    ]).animate(CurvedAnimation(parent: _controller1, curve: Curves.easeInOut));

    // // For Teacher's video animation
    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    setC2ForFirstAnimation();

    // // For Left Overlays animation
    _controller3 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    // Slide movement
    _positionAnimationC3 = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(-0.7, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller3,
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.elasticIn,
      ),
    );

    // // For Right Overlays animation
    _controller4 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    // Slide movement
    _positionAnimationC4 = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0.7, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller4,
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.elasticIn,
      ),
    );

    // // For Student's video animation
    _controller5 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    setC5ForFirstAnimation();

    // // For Stacked Cards animation
    _controller6 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    // Horizontal movement
    _positionAnimationC6 = [
      Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0)).animate(
        CurvedAnimation(parent: _controller6, curve: Curves.elasticOut),
      ),
      Tween<Offset>(begin: Offset(2, 0), end: Offset(0, 0)).animate(
        CurvedAnimation(parent: _controller6, curve: Curves.elasticOut),
      ),
      Tween<Offset>(begin: Offset(3, 0), end: Offset(0, 0)).animate(
        CurvedAnimation(parent: _controller6, curve: Curves.elasticOut),
      ),
      Tween<Offset>(begin: Offset(4, 0), end: Offset(0, 0)).animate(
        CurvedAnimation(parent: _controller6, curve: Curves.elasticOut),
      ),
    ];

    // // For chat bubble animation
    _controller7 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    // Scale up
    _sizeAnimationC7 = [
      Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller7,
          curve: Interval(0.5, 0.65, curve: Curves.easeIn),
        ),
      ),
      Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller7,
          curve: Interval(0.65, 0.8, curve: Curves.easeIn),
        ),
      ),
      Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller7,
          curve: Interval(0.8, 0.95, curve: Curves.easeIn),
        ),
      ),
    ];
  }

  // Animation value setter for second controller
  setC2ForFirstAnimation({bool reset = false}) {
    // Vertical movement
    _positionAnimationC2 = Tween<Alignment>(
      begin: Alignment(0, -1.7),
      end: Alignment(0, -0.57),
    ).animate(CurvedAnimation(parent: _controller2, curve: Curves.easeInOut));

    // Shape animation
    _widthAnimationC2 = AlwaysStoppedAnimation(0.34);
    _heightAnimationC2 = AlwaysStoppedAnimation(0.097);
    _borderAnimationC2 = AlwaysStoppedAnimation(15);
    _shadowAnimationC2 = AlwaysStoppedAnimation(Offset(3.0, 4.0));

    if (reset) {
      _controller2.forward(from: 1);
    }
  }

  // Animation value setter for second controller
  setC2ForSecondAnimation() {
    _widthAnimationC2 = Tween<double>(
      begin: 0.34,
      end: 0.096,
    ).animate(CurvedAnimation(parent: _controller2, curve: Curves.easeInOut));
    _heightAnimationC2 = Tween<double>(
      begin: 0.097,
      end: 0.045,
    ).animate(CurvedAnimation(parent: _controller2, curve: Curves.easeInOut));
    _borderAnimationC2 = Tween<double>(
      begin: 15,
      end: 60,
    ).animate(CurvedAnimation(parent: _controller2, curve: Curves.easeInOut));
    _shadowAnimationC2 = Tween<Offset>(
      begin: Offset(3.0, 4.0),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller2, curve: Curves.easeInOut));
    _positionAnimationC2 = Tween<Alignment>(
      begin: Alignment(0, -0.57),
      end: Alignment(-0.915, -0.598),
    ).animate(CurvedAnimation(parent: _controller2, curve: Curves.easeInOut));
  }

  // Animation value setter for fifth controller
  setC5ForFirstAnimation({bool reset = false}) {
    // Vertical movement
    _positionAnimationC5 = Tween<Alignment>(
      begin: Alignment(0, -0.025),
      end: Alignment(0, 0.45),
    ).animate(CurvedAnimation(parent: _controller5, curve: Curves.easeInOut));

    // Scale Transformation
    _sizeAnimationC5 = Tween<double>(
      begin: 0.26,
      end: 0.09,
    ).animate(CurvedAnimation(parent: _controller5, curve: Curves.easeInOut));
    if (reset) {
      _controller5.forward(from: 1);
    }
  }

  // Animation value setter for fifth controller
  setC5ForSecondAnimation() {
    // Position movement
    _positionAnimationC5 = Tween<Alignment>(
      begin: Alignment(0, 0.45),
      end: Alignment(0.91, -0.158),
    ).animate(CurvedAnimation(parent: _controller5, curve: Curves.easeInOut));

    // Scale Transformation
    _sizeAnimationC5 = Tween<double>(
      begin: 0.09,
      end: 0.045,
    ).animate(CurvedAnimation(parent: _controller5, curve: Curves.easeInOut));
  }

  // Next Page On Press method
  void _nextPage() {
    if (_isAnimating) return;
    setState(() {
      _isAnimating = true;
    });

    if (_currentPage == 0) {
      _controller1.forward();
      _controller2.forward();
      _controller3.forward();
      _controller4.forward();
      _controller5.forward();
      _controller6.forward().then((_) {
        setState(() {
          _isAnimating = false;
        });
      });
    } else if (_currentPage == 1) {
      setC2ForSecondAnimation();
      _controller2.reset();
      _controller2.forward();
      setC5ForSecondAnimation();
      _controller5.reset();
      _controller5.forward();
      _controller7.forward().then((_) {
        setState(() {
          _isAnimating = false;
        });
      });
    } else {
      setState(() {
        _isAnimating = false;
      });
    }

    _pageController.nextPage(
      duration: Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }

  // Previous Page On Press method
  void _previousPage() {
    if (_isAnimating) return;
    setState(() {
      _isAnimating = true;
    });

    if (_currentPage == 1) {
      _controller1.reverse();
      setC2ForFirstAnimation(reset: true);
      _controller2.reverse();
      _controller3.reverse();
      _controller4.reverse();
      setC5ForFirstAnimation(reset: true);
      _controller5.reverse();
      _controller6.reverse().then((_) {
        setState(() {
          _isAnimating = false;
        });
      });
    } else if (_currentPage == 2) {
      _controller7.reset();
      _controller6.reset();
      _controller6.forward();
      _controller2.reverse();
      _controller5.reverse().then((_) {
        setState(() {
          _isAnimating = false;
        });
      });
    }
    _pageController.previousPage(
      duration: Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Initializing Pages
    List<Widget> pages = [
      pageOne(context),
      pageTwo(context),
      pageThree(context),
    ];
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // // Animated  Circle Spray rotation effect
            BackgroundAnimation(),

            // // Page View
            Padding(
              padding: EdgeInsets.only(top: context.mqSize.height * 0.095),
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                physics: NeverScrollableScrollPhysics(),
                children: pages,
              ),
            ),

            // // Teacher's Video
            AnimatedBuilder(
              animation: _controller2,
              builder: (context, child) {
                return Align(
                  // alignment: Alignment(0, -0.57), //desired position
                  alignment: _positionAnimationC2.value,
                  child: Padding(
                    padding: EdgeInsets.only(top: context.mqSize.height * 0.06),
                    child: Container(
                      height: context.mqSize.height * _heightAnimationC2.value,
                      width: context.mqSize.width * _widthAnimationC2.value,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          _borderAnimationC2.value,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            offset: _shadowAnimationC2.value,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          _borderAnimationC2.value,
                        ),
                        child: VideoWidget(asset: 'assets/teachervideo.mp4'),
                      ),
                    ),
                  ),
                );
              },
            ),

            // // Animated Logo
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: context.mqSize.height * 0.03),
                  child: AnimatedBuilder(
                    animation: _controller1,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: _positionAnimationC1.value,
                        child: Transform.scale(
                          scale: _sizeAnimationC1.value,
                          child: child,
                        ),
                      );
                    },
                    child: LogoWidget(
                      height: context.mqSize.height * 0.045,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
              ],
            ),

            // // Circular student video
            AnimatedBuilder(
              animation: _controller5,
              builder: (context, child) {
                return Align(
                  alignment: _positionAnimationC5.value,
                  child: CircularVideoWidget(
                    asset: 'assets/studentvideo.mp4',
                    dimension: context.mqSize.height * _sizeAnimationC5.value,
                    showCamera: true,
                  ),
                );
              },
            ),

            // // Overlay Holder (Left slide animation)
            SlideTransition(
              position: _positionAnimationC3,
              child: Align(
                alignment: Alignment(0, -0.025),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OverlaysHolderWidget(
                      children: [
                        // Overlays
                        Positioned(
                          bottom: context.mqSize.height * 0.0114,
                          left: context.mqSize.width * 0.122,
                          child: OverlayWidget(
                            child: ItalicTextWidget(
                              text: 'Doubt Clarification',
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: context.mqSize.height * 0.091,
                          left: context.mqSize.width * 0.16,
                          child: OverlayWidget(
                            child: SizedBox.square(
                              dimension: context.mqSize.height * 0.031,
                              child: Image.asset(
                                'assets/pre_read_selected.png',
                              ),
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
                  ],
                ),
              ),
            ),

            // // Overlay Holder (Right slide animation)
            SlideTransition(
              position: _positionAnimationC4,
              child: Align(
                // alignment: Alignment(0, -0.025),   // Original position
                alignment: Alignment(0, 0.11),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OverlaysHolderWidget(
                      children: [
                        // Overlays
                        Positioned(
                          top: context.mqSize.height * 0.034,
                          right: context.mqSize.width * 0.073,
                          child: OverlayWidget(
                            child: ItalicTextWidget(
                              text: 'Holistic Well-Being',
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: context.mqSize.height * 0.057,
                          right: context.mqSize.width * 0.109,
                          child: OverlayWidget(
                            child: ItalicTextWidget(text: 'Personalised'),
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
              ),
            ),

            // // Next Button
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
                        onTap: _previousPage,
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
                    onPressed: _nextPage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Page One method for PageView
  Widget pageOne(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        TitleText('Learning Made\nPersonal', textAlign: TextAlign.center),
        SubtitleText(text: 'A Program designed just for YOU!'),
        SizedBox(height: context.mqSize.height * 0.1),

        // Middle Lottie Animation with Yellow circular border
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
                        scale: context.mqSize.height * 0.0016,
                        child: Lottie.asset(
                          'assets/sparkl_shape_shift_lottie.json',
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
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // Page Two method for PageView
  Widget pageTwo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.mqSize.width * 0.041),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText('1-on-1 Live Classes'),
          SubtitleText(text: ' Learning customized for every student'),

          // Teacher's Placeholder
          SizedBox(height: 0.157 * context.mqSize.height),

          // Stacked stack cards with student video
          Padding(
            padding: EdgeInsets.only(bottom: context.mqSize.height * 0.037),
            child: StackedCards(position: _positionAnimationC6),
          ),
        ],
      ),
    );
  }

  // Page Three method for PageView
  Widget pageThree(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.mqSize.width * 0.041),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(
            'Doubt Resolution\nwith Teachers',
            textAlign: TextAlign.left,
          ),
          SizedBox(height: context.mqSize.height * 0.034),
          CustomChatBubble(
            text:
                'Do you want to go over\nhow to apply the\nquadratic formula?',
            isTeacher: true,
            sizeAnimation: _sizeAnimationC7[0],
          ),
          SizedBox(height: context.mqSize.height * 0.0205),
          CustomChatBubble(
            text: 'Yes, I\'m confused about\nwhen to use it.',
            isTeacher: false,
            sizeAnimation: _sizeAnimationC7[1],
          ),
          SizedBox(height: context.mqSize.height * 0.0205),
          CustomChatBubble(
            text:
                'You can use it when the\nequation is in the form ax\u00B2 +\nbx + c = 0. Let me show you\na quick example to clarify.',
            isTeacher: true,
            rightPadding: 0.048,
            showVideo: true,
            sizeAnimation: _sizeAnimationC7[2],
          ),
        ],
      ),
    );
  }
}
