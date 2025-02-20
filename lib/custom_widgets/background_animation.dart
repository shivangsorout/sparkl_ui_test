import 'dart:ui';
import 'package:flutter/material.dart';

// Main animation class for animating all the circles
class BackgroundAnimation extends StatefulWidget {
  const BackgroundAnimation({super.key});

  @override
  State<BackgroundAnimation> createState() => _BackgroundAnimationState();
}

class _BackgroundAnimationState extends State<BackgroundAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentIndex = 0;

  // Animation sequence spray circles keyframes offset list
  final sequence = AnimationSequenceData(
    sequences: [
      [
        CircleData(
          id: '1',
          normalizedPosition: Offset(0.0, 0.5),
          radius: 80,
          color: Color(0xfffbd044),
        ),
        CircleData(
          id: '2',
          normalizedPosition: Offset(0.2, 0.7),
          radius: 45,
          color: Color(0xffa7f5d4),
        ),
      ],
      [
        CircleData(
          id: '1',
          normalizedPosition: Offset(0.2, 0.3),
          radius: 73,
          color: Color(0xfffbd044),
        ),
        CircleData(
          id: '2',
          normalizedPosition: Offset(0.0, 0.4),
          radius: 50,
          color: Color(0xffa7f5d4),
        ),
      ],

      [
        CircleData(
          id: '1',
          normalizedPosition: Offset(0.5, 0.1),
          radius: 69,
          color: Color(0xfffbd044),
        ),
        CircleData(
          id: '2',
          normalizedPosition: Offset(0.6, 0.3),
          radius: 60,
          color: Color(0xffa7f5d4),
        ),
      ],

      [
        CircleData(
          id: '1',
          normalizedPosition: Offset(0.6, 0.3),
          radius: 63,
          color: Color(0xfffbd044),
        ),
        CircleData(
          id: '2',
          normalizedPosition: Offset(0.7, 0.1),
          radius: 65,
          color: Color(0xffa7f5d4),
        ),
      ],
      [
        CircleData(
          id: '1',
          normalizedPosition: Offset(1.0, 0.5),
          radius: 60,
          color: Color(0xfffbd044),
        ),
        CircleData(
          id: '2',
          normalizedPosition: Offset(0.7, 0.6),
          radius: 73,
          color: Color(0xffa7f5d4),
        ),
      ],
      [
        CircleData(
          id: '1',
          normalizedPosition: Offset(0.8, 0.8),
          radius: 57,
          color: Color(0xfffbd044),
        ),
        CircleData(
          id: '2',
          normalizedPosition: Offset(1.0, 0.7),
          radius: 77,
          color: Color(0xffa7f5d4),
        ),
      ],
      [
        CircleData(
          id: '1',
          normalizedPosition: Offset(0.5, 1.0),
          radius: 53,
          color: Color(0xfffbd044),
        ),
        CircleData(
          id: '2',
          normalizedPosition: Offset(0.4, 0.8),
          radius: 80,
          color: Color(0xffa7f5d4),
        ),
      ],
      [
        CircleData(
          id: '1',
          normalizedPosition: Offset(0.4, 0.8),
          radius: 45,
          color: Color(0xfffbd044),
        ),
        CircleData(
          id: '2',
          normalizedPosition: Offset(0.3, 1.0),
          radius: 85,
          color: Color(0xffa7f5d4),
        ),
      ],
      // Add more keyframes as needed
    ],
    stepDuration: Duration(seconds: 3),
    onSequenceChange: (index) {
      print('Moved to keyframe $index');
    },
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: sequence.stepDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: Tween<double>(begin: 0, end: 1).animate(_controller),
      curve: Curves.linear,
    );

    // attaching _updateSequence method with the controller status listener
    _controller.addStatusListener(_updateSequence);
    _controller.forward();
  }

  // Updating keyframes function setting the offset values of circles for animation
  void _updateSequence(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % sequence.length;
        sequence.onSequenceChange?.call(_currentIndex);
      });
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: CustomCirclesPainter(
            startCircles: sequence.sequences[_currentIndex],
            endCircles:
                sequence.sequences[(_currentIndex + 1) % sequence.length],
            progress: _animation.value,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

// Custom circle painter class for drawing circle
class CustomCirclesPainter extends CustomPainter {
  final List<CircleData> startCircles;
  final List<CircleData> endCircles;
  final double progress;

  CustomCirclesPainter({
    required this.startCircles,
    required this.endCircles,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < startCircles.length; i++) {
      var startCircle = startCircles[i];
      var endCircle = endCircles.firstWhere(
        (c) => c.id == startCircle.id,
        orElse: () => startCircle,
      );
      var lerpedCircle = startCircle.lerp(endCircle, progress);

      var position = Offset(
        lerpedCircle.normalizedPosition.dx * size.width,
        lerpedCircle.normalizedPosition.dy * size.height,
      );

      var paint =
          Paint()
            ..color = lerpedCircle.color
            ..style = PaintingStyle.fill
            ..maskFilter = MaskFilter.blur(BlurStyle.normal, 40);

      canvas.drawCircle(position, lerpedCircle.radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomCirclesPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.startCircles != startCircles ||
        oldDelegate.endCircles != endCircles;
  }
}

// // Primary classes for storing circles Data and primary circle data class

// Animation sequence class for storing circle offsets data
class AnimationSequenceData {
  final List<List<CircleData>> sequences;
  final Duration stepDuration;
  final Function(int)? onSequenceChange;

  AnimationSequenceData({
    required this.sequences,
    this.stepDuration = const Duration(seconds: 1),
    this.onSequenceChange,
  });

  int get length => sequences.length;
}

// Primary circle class for defining offsets and radius of the circle
class CircleData {
  final String id;
  final Offset normalizedPosition;
  final double radius;
  final Color color;

  CircleData({
    required this.id,
    required this.normalizedPosition,
    required this.radius,
    required this.color,
  }) : assert(
         normalizedPosition.dx >= 0 &&
             normalizedPosition.dx <= 1 &&
             normalizedPosition.dy >= 0 &&
             normalizedPosition.dy <= 1,
         "Normalized position must be between 0 and 1",
       );

  CircleData lerp(CircleData other, double t) {
    return CircleData(
      id: id,
      normalizedPosition:
          Offset.lerp(normalizedPosition, other.normalizedPosition, t)!,
      radius: lerpDouble(radius, other.radius, t)!,
      color: Color.lerp(color, other.color, t)!,
    );
  }
}
