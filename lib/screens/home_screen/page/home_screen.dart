import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/screens/home_screen/controller/video_controller.dart';
import 'package:video_player_app/screens/home_screen/page/video_screen.dart';
import 'package:video_player_app/screens/video_list.dart';
import 'package:video_player_app/utils/colours.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  VideoController videoController = Get.find();
  List<Controllers> controllerList = [];
  Controllers? controller;

  void myVideos() async {
    controllerList = [
      Controllers(
        videoPlayerController: VideoPlayerController.asset("${videoList[0]["source"]}")..initialize().then((value) => setState(() {})),
      ),
      Controllers(
        videoPlayerController: VideoPlayerController.asset("${videoList[1]["source"]}")..initialize().then((value) => setState(() {})),
      ),
      /* Controllers(
        videoPlayerController:
            VideoPlayerController.asset("${videoList[2]["source"]}")
              ..initialize().then((value) => setState(() {})),
      ),
      Controllers(
        videoPlayerController:
            VideoPlayerController.asset("${videoList[3]["source"]}")
              ..initialize().then((value) => setState(() {})),
      ),
      Controllers(
        videoPlayerController:
            VideoPlayerController.asset("${videoList[4]["source"]}")
              ..initialize().then((value) => setState(() {})),
      ),
      Controllers(
        videoPlayerController:
            VideoPlayerController.asset("${videoList[5]["source"]}")
              ..initialize().then((value) => setState(() {})),
      ),
      Controllers(
        videoPlayerController:
            VideoPlayerController.asset("${videoList[6]["source"]}")
              ..initialize().then((value) => setState(() {})),
      ),
      Controllers(
        videoPlayerController:
            VideoPlayerController.asset("${videoList[7]["source"]}")
              ..initialize().then((value) => setState(() {})),
      ),
      Controllers(
        videoPlayerController:
            VideoPlayerController.asset("${videoList[8]["source"]}")
              ..initialize().then((value) => setState(() {})),
      ),
      Controllers(
        videoPlayerController:
            VideoPlayerController.asset("${videoList[9]["source"]}")
              ..initialize().then((value) => setState(() {})),
      ),*/
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myVideos();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() => Stack(
            children: [
              Scaffold(
                backgroundColor: colorWhite,
                appBar: AppBar(
                  elevation: 0,
                  centerTitle: true,
                  title: const Text(
                    "Video Player",
                    style: TextStyle(
                      color: colorBlack,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: colorWhite,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 740,
                        width: double.infinity,
                        child: ListView(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: controllerList
                                    .map(
                                      (controller) => Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: InkWell(
                                          onTap: () {
                                            if (videoController.isShow.value) {
                                              videoController.isShow.value = false;
                                              controller = controller;
                                            } else {
                                              controller = controller;
                                            }
                                            videoController.isInSmallMode.value = false;
                                            videoController.currentVideoHeight.value = 200.0;
                                            videoController.currentVideoWidth.value = 200.0;
                                            videoController.currentAlignment.value = Alignment.topCenter;
                                            videoController.isShow.value = true;
                                          },
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 200,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Chewie(
                                                  controller: ChewieController(
                                                    aspectRatio: 16 / 9,
                                                    videoPlayerController: controller.videoPlayerController!,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "${videoList[controllerList.indexOf(controller)]["title"]}",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "${videoList[controllerList.indexOf(controller)]["subtitle"]}",
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              videoController.isShow.value ? VideoPlayScreen(controllerList.indexOf(controller ?? controllerList[0])) : Container(),
            ],
          )),
    );
  }
}
