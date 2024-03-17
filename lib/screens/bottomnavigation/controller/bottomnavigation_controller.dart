import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  RxInt selectIndex = 0.obs;
  RxDouble fontSize = 0.0.obs;
  RxList listOfStrings =[].obs;
  RxList listOfIcons = [
    Icons.home,
    Icons.home,
    Icons.home,
    Icons.home,
  ].obs;

  @override
  void onInit() {
    super.onInit();
    selectIndex.value = 0;
    listOfStrings.value = [
     "Home",
     "Second",
     "Third",
     "Forth",
    ];
  }

  void onItemTapped(int index) {
    selectIndex.value = index;
    update();
  }
}
