import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/ui/controllers/binder/binder_controllers.dart';
import 'package:task_manager_getx/ui/screen/dash_board_screen.dart';
import 'package:task_manager_getx/ui/screen/email_verification_screen.dart';
import 'package:task_manager_getx/ui/screen/pin_verification_screen.dart';
import 'package:task_manager_getx/ui/screen/set_password_screen.dart';
import 'package:task_manager_getx/ui/screen/sign_in_screen.dart';
import 'package:task_manager_getx/ui/screen/sign_up_screen.dart';
import 'package:task_manager_getx/ui/screen/splash_screen.dart';
import 'package:task_manager_getx/ui/screen/task_add_screen.dart';
import 'package:task_manager_getx/ui/utils/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: AppColors.themeColor,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(10)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            fixedSize: Size.fromWidth(double.maxFinite),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(vertical: 12),
            backgroundColor: AppColors.themeColor,
            foregroundColor: Colors.white,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.green),
        ),
      ),

      initialBinding: BinderControllers(),
      initialRoute: SplashScreen.name,

      getPages: [
        // Splash Screen
        GetPage(name: SplashScreen.name, page: () => SplashScreen()),
        // Sign Up Screen
        GetPage(name: SignUpScreen.name, page: () => SignUpScreen()),
        // Sign In Screen
        GetPage(name: SignInScreen.name, page: () => SignInScreen()),
        // EmailVerificationScreen
        GetPage(name: EmailVerificationScreen.name, page: () => EmailVerificationScreen(),),
        // PinVerificationScreen
        GetPage(name: PinVerificationScreen.name, page: () => PinVerificationScreen(),),
        // Password Set Screen
        GetPage(name: SetPasswordScreen.name, page: () => SetPasswordScreen()),
        // Home Screen
        GetPage(name: DashBoardScreen.name, page: () => DashBoardScreen()),
        // Task Add Screen
        GetPage(name: TaskAddScreen.routeName, page: () => TaskAddScreen()),

      ],
    );
  }
}
