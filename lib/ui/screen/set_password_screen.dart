
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/ui/screen/pin_verification_screen.dart';
import 'package:task_manager_getx/ui/screen/sign_in_screen.dart';

import '../controllers/auth_controller/set_password_controller.dart';
import '../utils/app_colors.dart';
import '../widgets/input_from_filed.dart';
import '../widgets/screen_bg.dart';
import '../widgets/top_text_field.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});
  static String name = '/SetPasswordScreen';

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {

    final SetPasswordController setPasswordController=  Get.find<SetPasswordController>();
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GetBuilder<SetPasswordController>(
              builder: (controller) {
                return SingleChildScrollView(
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          TopTextField(title: 'Set Your Password'),
                          SizedBox(height: 10),
                          Text("Minimum length password 8 character with\n Latter and number combination ",style: TextStyle(
                              color: Colors.grey
                          ),),
                          const SizedBox(height: 30),
                          InputFromFiled(
                            controller: passwordController,
                            hint: 'Password',
                            inputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 10),
                          InputFromFiled(
                            controller: confirmPasswordController,
                            hint: 'Confirm Password',
                            inputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),

                          // Sign Up Button
                          Visibility(
                            visible: !_inProgress,
                            replacement: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: AppColors.themeColor,
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                Get.toNamed(PinVerificationScreen.name);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.themeColor,
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: Icon(
                                Icons.arrow_circle_left_outlined,
                                size: 24,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          // RichText to navigate to Sign In screen
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: "Have account? ",
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Sign In",
                                    style: TextStyle(
                                      color: AppColors.themeColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () =>
                                          Get.offNamedUntil(SignInScreen.name, (route) => false),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
