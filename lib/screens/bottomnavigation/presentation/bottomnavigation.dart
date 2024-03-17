import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player_app/screens/bottomnavigation/controller/bottomnavigation_controller.dart';
import 'package:video_player_app/screens/home_screen/page/home_screen.dart';
import 'package:video_player_app/utils/app_colors.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  final BottomNavigationController _bottomNavigationController = Get.put(BottomNavigationController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // listener.cancel();
  }

  final widgetOptions = [
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      body: Obx(
        () => Center(
          child: widgetOptions.elementAt(_bottomNavigationController.selectIndex.value),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: displayWidth * .05, vertical: 2.w),
        height: displayWidth * .155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
          itemBuilder: (context, index) => InkWell(
              onTap: () {
                _bottomNavigationController.selectIndex.value = index;
                HapticFeedback.lightImpact();
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Obx(
                () => Stack(
                  children: [
                    AnimatedContainer(
                      duration: Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      width: index == _bottomNavigationController.selectIndex.value ? displayWidth * .32 : displayWidth * .18,
                      alignment: Alignment.center,
                      child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        height: index == _bottomNavigationController.selectIndex.value ? displayWidth * .12 : 0,
                        width: index == _bottomNavigationController.selectIndex.value ? displayWidth * .32 : 0,
                        decoration: BoxDecoration(
                          color: index == _bottomNavigationController.selectIndex.value
                              ? Colors.blueAccent.withOpacity(.2)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                      width: index == _bottomNavigationController.selectIndex.value ? displayWidth * .31 : displayWidth * .18,
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width: index == _bottomNavigationController.selectIndex.value ? displayWidth * .10 : 0,
                              ),
                              AnimatedOpacity(
                                opacity: index == _bottomNavigationController.selectIndex.value ? 1 : 0,
                                duration: Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: Container(
                                  width: 18.w,
                                  child: Text(
                                    index == _bottomNavigationController.selectIndex.value
                                        ? _bottomNavigationController.listOfStrings[index]
                                        : '',
                                    // overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width: index == _bottomNavigationController.selectIndex.value ? displayWidth * .03 : 20,
                              ),
                              Icon(
                                _bottomNavigationController.listOfIcons[index],
                                color: index == _bottomNavigationController.selectIndex.value ? AppColors.primaryColor : Colors.black26,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
