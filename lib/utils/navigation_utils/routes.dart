import 'package:get/get.dart';
import 'package:video_player_app/screens/bottomnavigation/presentation/bottomnavigation.dart';
import 'package:video_player_app/screens/home_screen/page/home_screen.dart';

mixin Routes {
  static const defaultTransition = Transition.rightToLeft;

  // get started
  static const String splash = '/splash';
  static const String homeScreen = '/home';
  static const String bottomNavigation = '/bottomNavigation';
  static const String fontSizeScreen = '/fontSizeScreen';
  static const String langPrefScreen = '/langPrefScreen';
  static const String settingScreen = '/settingScreen';
  static const String selectSoundScreen = '/selectSoundScreen';
  static const String tinnitusScreen = '/tinnitusScreen';

  static List<GetPage<dynamic>> pages = [

    GetPage<dynamic>(
      name: homeScreen,
      page: () => HomePage(),
      transition: defaultTransition,
    ),
    GetPage<dynamic>(
      name: bottomNavigation,
      page: () => const BottomNavigationBarScreen(),
      transition: defaultTransition,
    ),
  ];
}
