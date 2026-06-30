import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../widget/AppImage/app_image.dart';

// Call this anywhere to open full screen image
void openFullScreenImage(String imagePath, {bool isFile = false}) {
  Get.to(
        () => FullScreenImageViewer(imagePath: imagePath, isFile: isFile),
    transition: Transition.fadeIn,
    duration: const Duration(milliseconds: 250),
  );
}

// Full Screen Image Viewer
class FullScreenImageViewer extends StatefulWidget {
  final String imagePath;
  final bool isFile;

  const FullScreenImageViewer({super.key, required this.imagePath, this.isFile = false});

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  final TransformationController _transformController = TransformationController();
  final _showUI = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    // Hide status bar for immersive experience
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    // Restore status bar
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _transformController.dispose();
    _showUI.dispose();
    super.dispose();
  }

  void _resetZoom() {
    _transformController.value = Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        // Single tap → toggle UI
        onTap: () => _showUI.value = !_showUI.value,
        // Double tap → reset zoom
        onDoubleTap: _resetZoom,
        child: Stack(
          children: [
            //Zoomable Image
            Center(
              child: InteractiveViewer(
                transformationController: _transformController,
                minScale: 0.5,
                maxScale: 5.0,
                child: AppImage(
                  path: widget.isFile ? null : widget.imagePath,
                  filePath: widget.isFile ? widget.imagePath : null,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            //Close Button
            ValueListenableBuilder<bool>(
              valueListenable: _showUI,
              builder: (_, show, _) => AnimatedOpacity(
                opacity: show ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(12.r),
                    child: GestureDetector(
                      onTap: Get.back,
                      child: Container(
                        width: 38.r,
                        height: 38.r,
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(140),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}