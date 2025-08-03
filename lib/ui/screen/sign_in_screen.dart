import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/ui/screen/email_verification_screen.dart';
import 'package:task_manager_getx/ui/screen/sign_up_screen.dart';

import '../controllers/auth_controller/sign_in_controller.dart';

import '../utils/app_colors.dart';
import '../widgets/input_from_filed.dart';
import '../widgets/screen_bg.dart';
import '../widgets/top_text_field.dart';
import 'dash_board_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static String name = '/SignInScreen';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _signInProgress = false;

  @override
  Widget build(BuildContext context) {
    final SignInController controller = Get.find<SignInController>();
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GetBuilder<SignInController>(
              builder: (_) {
                return SingleChildScrollView(
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TopTextField(title: 'Get Started with'),
                          const SizedBox(height: 30),
                          InputFromFiled(
                            controller: emailController,
                            hint: 'Email',
                            inputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),
                          InputFromFiled(
                            controller: passwordController,
                            hint: 'Password',
                            inputType: TextInputType.visiblePassword,
                          ),
                          const SizedBox(height: 20),

                          // Sign Up Button
                          Visibility(
                            visible: !_signInProgress,
                            replacement: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: AppColors.themeColor,
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => _signInProgress = true);
                                  controller.signIn(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                  ).then((isSuccess) {
                                    setState(() => _signInProgress = false);
                                    if (isSuccess) {
                                      // Get.offAllNamed('/home');
                                      Get.offNamedUntil(DashBoardScreen.name, (route) => false);
                                    } else {
                                      Get.snackbar(
                                        'Error',
                                        controller.errorMessage.value,
                                        snackPosition: SnackPosition.BOTTOM,
                                      );
                                    }
                                  });
                                }
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
                          const SizedBox(height: 40),

                          // Forgot Password Button
                          Center(
                            child: TextButton(
                              onPressed: () {
                                Get.toNamed(EmailVerificationScreen.name);
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // RichText to navigate to Sign In screen
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: "Don't have account? ",
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Sign Up",
                                    style: TextStyle(
                                      color: AppColors.themeColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () =>
                                          Get.toNamed(SignUpScreen.name),
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
