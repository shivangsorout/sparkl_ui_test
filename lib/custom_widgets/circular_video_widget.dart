import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sparkl_ui_test/custom_widgets/video_widget.dart';
import 'package:sparkl_ui_test/main.dart';

class CircularVideoWidget extends StatefulWidget {
  final double dimension;
  final String asset;
  final bool showCamera;
  const CircularVideoWidget({
    super.key,
    required this.dimension,
    required this.asset,
    this.showCamera = false,
  });

  @override
  State<CircularVideoWidget> createState() => _CircularVideoWidgetState();
}

class _CircularVideoWidgetState extends State<CircularVideoWidget> {
  late CameraController _cameraController;
  bool _useCamera = false;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(camerasList[1], ResolutionPreset.max);
    if (widget.showCamera) {
      initializingCamera();
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  initializingCamera() {
    _cameraController
        .initialize()
        .then((_) {
          if (!mounted) {
            return;
          }
          setState(() {
            _useCamera = true;
          });
        })
        .catchError((Object e) {
          if (e is CameraException) {
            switch (e.code) {
              case 'CameraAccessDenied':
                setState(() {
                  _useCamera = false;
                });
                break;
              default:
                // Handle other errors here.
                break;
            }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox.square(
        dimension: widget.dimension,
        child: Visibility(
          visible: !_useCamera,
          replacement: FittedBox(
            fit: BoxFit.fitHeight,
            child: SizedBox.square(
              dimension: _cameraController.value.previewSize?.height,
              child: CameraPreview(_cameraController),
            ),
          ),
          child: VideoWidget(asset: widget.asset),
        ),
      ),
    );
  }
}
