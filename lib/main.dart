import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sparkl_ui_test/extensions/build_context.dart';
import 'package:video_player/video_player.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: context.mqSize.height * 0.021),
                LogoWidget(),
                SizedBox(height: context.mqSize.height * 0.03),
                Text(
                  'Learning Made\nPersonal',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.mqSize.height * 0.045,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'A Program designed just for YOU!',
                  style: TextStyle(
                    fontSize: context.mqSize.height * 0.023,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff525352),
                  ),
                ),
                SizedBox(height: context.mqSize.height * 0.1),
                Row(
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Transform.scale(
                            scale: 1.4,
                            child: Lottie.asset(
                              'assets/sparkl_shape_shift_lottie.json',
                            ),
                          ),
                          ClipOval(
                            child: SizedBox.square(
                              dimension: context.mqSize.height * 0.26,
                              child: VideoWidget(
                                asset: 'assets/studentvideo.mp4',
                              ),
                            ),
                          ),
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
                          Positioned(
                            top: 30,
                            right: 30,
                            child: OverlayWidget(
                              child: ItalicTextWidget(
                                text: 'Holistic Well-Being',
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 50,
                            right: 45,
                            child: OverlayWidget(
                              child: ItalicTextWidget(text: 'Personalised'),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 50,
                            child: OverlayWidget(
                              child: ItalicTextWidget(
                                text: 'Doubt Clarification',
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 80,
                            left: 65,
                            child: OverlayWidget(
                              child: SizedBox.square(
                                dimension: 27,
                                child: Image.asset(
                                  'assets/pre_read_selected.png',
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 90,
                            child: OverlayWidget(
                              child: SizedBox.square(
                                dimension: 35,
                                child: Image.asset('assets/blue_book.png'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, left: 80),
                  child: OverlayWidget(
                    child: SizedBox.square(
                      dimension: 30,
                      child: Image.asset('assets/emoji.png'),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.mqSize.width * 0.048,
                  vertical: context.mqSize.height * 0.021,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                        height: 48,
                        color: Color(0xfffbd044),
                        child: Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OverlayWidget extends StatelessWidget {
  final Widget child;
  const OverlayWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      padding: EdgeInsets.zero,
      strokeWidth: 3,
      borderType: BorderType.RRect,
      radius: Radius.circular(40),
      color: Color(0xfff9d558),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
          child: Container(
            color: Colors.white.withAlpha((255 * 0.7).round()),
            padding: EdgeInsets.all(8),
            child: child,
          ),
        ),
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

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(
        'assets/sparkl_logo.png',
        height: context.mqSize.height * 0.045,
      ),
    );
  }
}

class VideoWidget extends StatefulWidget {
  final String asset;

  const VideoWidget({super.key, required this.asset});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _initVideoPlayer();
    super.initState();
  }

  _initVideoPlayer() {
    _controller = VideoPlayerController.asset(widget.asset);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          double videoWidth = _controller.value.size.width;
          double videoHeight = _controller.value.size.height;
          return FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: videoWidth,
              height: videoHeight,
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
