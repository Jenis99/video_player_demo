import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/screens/video_list.dart';
import 'package:video_player_app/utils/colours.dart';

import '../controller/video_controller.dart';

class VideoPlayScreen extends StatefulWidget {
  int index;

  VideoPlayScreen(this.index, {Key? key}) : super(key: key);

  @override
  _VideoPlayScreenState createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> with TickerProviderStateMixin {
  VideoController videoController = Get.find();

  late AnimationController alignmentAnimationController;
  late Animation alignmentAnimation;

  late AnimationController videoViewController;
  late Animation videoViewAnimation;

  var minVideoHeight = 100.0;
  var minVideoWidth = 150.0;

  var maxVideoHeight = 350.0;
  var maxVideoWidth = 400.0;

  late VideoPlayerController videoPlayerController;
  late ChewieController controller;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.asset("${videoList[widget.index]["source"]}")..initialize();
    controller = ChewieController(videoPlayerController: videoPlayerController);
    alignmentAnimationController = AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..addListener(() {
        setState(() {
          videoController.currentAlignment.value = alignmentAnimation.value;
        });
      });
    alignmentAnimation = AlignmentTween(begin: Alignment.topCenter, end: Alignment.bottomRight)
        .animate(CurvedAnimation(parent: alignmentAnimationController, curve: Curves.fastOutSlowIn));

    videoViewController = AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..addListener(() {
        setState(() {
          videoController.currentVideoWidth.value = (maxVideoWidth * videoViewAnimation.value) + (minVideoWidth * (1.0 - videoViewAnimation.value));
          videoController.currentVideoHeight.value = (maxVideoHeight * videoViewAnimation.value) + (minVideoHeight * (1.0 - videoViewAnimation.value));
        });
      });
    videoViewAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(videoViewController);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    videoPlayerController.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      maxVideoWidth = constraints.biggest.width;

      if (!videoController.isInSmallMode.value) {
        videoController.currentVideoWidth.value = maxVideoWidth;
      }
      return Obx(() => GestureDetector(
            onVerticalDragEnd: (details) {
              if (details.velocity.pixelsPerSecond.dy > 0) {
                setState(() {
                  print("Scrolling");
                  videoController.isInSmallMode.value = true;
                  alignmentAnimationController.forward();
                  videoViewController.forward();
                });
              } else if (details.velocity.pixelsPerSecond.dy < 0) {
                setState(() {
                  alignmentAnimationController.reverse();
                  videoViewController.reverse().then((value) {
                    setState(() {
                      videoController.isInSmallMode.value = false;
                    });
                  });
                });
              }
            },
            child: videoController.currentAlignment.value == Alignment.topCenter
                ? Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: colorWhite,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  child: Padding(
                                    padding: EdgeInsets.all(videoController.isInSmallMode.value ? 8.0 : 0.0),
                                    child: GestureDetector(
                                      child: Container(
                                        width: videoController.currentVideoWidth.value,
                                        height: videoController.currentVideoHeight.value,
                                        child: AspectRatio(
                                          aspectRatio: 6.5,
                                          child: Chewie(
                                            controller: controller,
                                          ),
                                        ),
                                      ),
                                      onVerticalDragEnd: (details) {
                                        if (details.velocity.pixelsPerSecond.dy > 0) {
                                          setState(() {
                                            videoController.isInSmallMode.value = true;
                                            alignmentAnimationController.forward();
                                            videoViewController.forward();
                                          });
                                        } else if (details.velocity.pixelsPerSecond.dy < 0) {
                                          setState(() {
                                            alignmentAnimationController.reverse();
                                            videoViewController.reverse().then((value) {
                                              setState(() {
                                                videoController.isInSmallMode.value = false;
                                              });
                                            });
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  alignment: videoController.currentAlignment.value,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "${videoList[widget.index]["title"]}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${videoList[widget.index]["subtitle"]}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Align(
                    child: Padding(
                      padding: EdgeInsets.all(videoController.isInSmallMode.value ? 8.0 : 0.0),
                      child: GestureDetector(
                        child: Container(
                          width: videoController.currentVideoWidth.value,
                          height: videoController.currentVideoHeight.value,
                          child: Chewie(
                            controller: controller,
                          ),
                        ),
                        onVerticalDragEnd: (details) {
                          if (details.velocity.pixelsPerSecond.dy > 0) {
                            setState(() {
                              videoController.isInSmallMode.value = true;
                              alignmentAnimationController.forward();
                              videoViewController.forward();
                            });
                          } else if (details.velocity.pixelsPerSecond.dy < 0) {
                            setState(() {
                              alignmentAnimationController.reverse();
                              videoViewController.reverse().then((value) {
                                setState(() {
                                  videoController.isInSmallMode.value = false;
                                });
                              });
                            });
                          }
                        },
                      ),
                    ),
                    alignment: videoController.currentAlignment.value,
                  ),
          ));
    });
  }
}
