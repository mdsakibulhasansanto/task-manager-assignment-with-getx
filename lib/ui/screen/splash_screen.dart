import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:task_manager_getx/ui/screen/dash_board_screen.dart';
import 'package:task_manager_getx/ui/screen/sign_in_screen.dart';
import 'package:task_manager_getx/ui/widgets/screen_bg.dart';

import '../controllers/auth_controller/auth_controllers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 2));

    bool isLoggedIn = await AuthController.isUserLoggedIn();
    if (isLoggedIn) {
      Get.toNamed(DashBoardScreen.name);
    } else {
      Get.toNamed(SignInScreen.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(child: Center(child: Text("Splash Screen"))),
    );
  }
}
