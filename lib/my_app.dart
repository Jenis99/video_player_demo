import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player_app/screens/home_screen/controller/video_controller.dart';
import 'package:video_player_app/utils/app_colors.dart';
import 'package:video_player_app/utils/app_string.dart';
import 'package:video_player_app/utils/navigation_utils/routes.dart';
import 'package:video_player_app/utils/utils.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppString.appName,
          theme: ThemeData(
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            colorScheme: ColorScheme.light(primary: AppColors.white),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            brightness: Brightness.light,
            disabledColor: AppColors.white,
            primaryColor: AppColors.white,
            textSelectionTheme: TextSelectionThemeData(cursorColor: AppColors.white),
            canvasColor: Colors.white,
            fontFamily: 'Lato',
            scaffoldBackgroundColor: AppColors.white,
          ),
          initialBinding: AppBidding(),
          initialRoute: Routes.bottomNavigation,
          getPages: Routes.pages,
          builder: (context, child) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: GestureDetector(
                onTap: () {
                  Utils.hideKeyboardInApp(context);
                },
                child: child,
              ),
            );
          },
        );
      },
    );
  }
}

class AppBidding extends Bindings {
  @override
  void dependencies() {
    Get.put<VideoController>(VideoController());
  }
}
