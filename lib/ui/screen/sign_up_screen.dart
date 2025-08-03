import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/ui/screen/sign_in_screen.dart';
import 'package:task_manager_getx/ui/widgets/input_from_filed.dart';
import 'package:task_manager_getx/ui/widgets/screen_bg.dart';

import '../controllers/auth_controller/sign_up_controller.dart';
import '../utils/app_colors.dart';
import '../widgets/top_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static String name = '/SignUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _signUpInProgress = false;

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.find<SignUpController>();
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GetBuilder<SignUpController>(
              builder: (_) {
                return SingleChildScrollView(
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TopTextField(title: 'Join with us'),
                          const SizedBox(height: 30),
                          InputFromFiled(
                            controller: emailController,
                            hint: 'Email',
                            inputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),
                          InputFromFiled(
                            controller: firstNameController,
                            hint: 'First Name',
                          ),
                          const SizedBox(height: 20),
                          InputFromFiled(
                            controller: lastNameController,
                            hint: 'Last Name',
                          ),
                          const SizedBox(height: 20),
                          InputFromFiled(
                            controller: mobileController,
                            hint: 'Mobile Number',
                            inputType: TextInputType.phone,
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
                            visible: !_signUpInProgress,
                            replacement: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: AppColors.themeColor,
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                // Validate the form
                                if (_signUpInProgress) return;
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _signUpInProgress = true;
                                  });
                                  controller
                                      .signUp(
                                        email: emailController.text.trim(),
                                        firstName: firstNameController.text.trim(),
                                        lastName: lastNameController.text.trim(),
                                        mobile: mobileController.text.trim(),
                                        password: passwordController.text.trim(),
                                      )
                                      .then((_) {
                                        setState(() {
                                          _signUpInProgress = false;
                                        });
                                      })
                                      .catchError((error) {
                                        _signUpInProgress = false;
                                        Get.snackbar(
                                          'Error',
                                          error.toString(),
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                        );
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

                          // RichText to navigate to Sign In screen
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: "Have an account? ",
                                style: const TextStyle(
                                  fontSize: 16,
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
                                          Get.toNamed(SignInScreen.name),
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

  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    mobileController.dispose();
    super.dispose();
  }
}
