import 'package:command_flutter/Styles/Colors.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'BasicOverlayWidget.dart';
import 'fullScreenVideo.dart';

class showVideo extends StatefulWidget {
  final videoURL;
  const showVideo({required this.videoURL, super.key});

  @override
  State<showVideo> createState() => _showVideoState();
}

class _showVideoState extends State<showVideo> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.videoURL)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller.play());
    // _initializeVideoPlayerFuture = controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Container(
          child: InteractiveViewer(
            child: controller.value.isInitialized
                ? Center(
                    child: AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: buildVideo()),
                  )
                : Center(
                    child: Container(
                    child: CircularProgressIndicator(color: purpleColor,),
                  )),
          ),
        ),
      ),
    );
  }

  Widget buildVideo() => Stack(
        children: [
          buildVideoPlayer(),
          Positioned.fill(child: BasicOverlayWidget(controller: controller)),
        ],
      );
  Widget buildVideoPlayer() => Center(
        child: VideoPlayer(controller),
      );
}
