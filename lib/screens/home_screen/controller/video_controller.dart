import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  Rx<Alignment> currentAlignment = Alignment.topCenter.obs;

  RxDouble minVideoHeight = 100.0.obs;
  RxDouble minVideoWidth = 150.0.obs;
  RxDouble maxVideoHeight = 350.0.obs;
  RxDouble maxVideoWidth = 400.0.obs;
  RxDouble currentVideoHeight = 200.0.obs;
  RxDouble currentVideoWidth = 200.0.obs;

  RxBool isInSmallMode = false.obs;

  RxBool isShow = false.obs;
  Rx<Controllers>? controller;
}

class Controllers {
  late VideoPlayerController? videoPlayerController;

  Controllers({this.videoPlayerController});
}