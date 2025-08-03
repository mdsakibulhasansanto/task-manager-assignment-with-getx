import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:task_manager_getx/ui/screen/set_password_screen.dart';
import 'package:task_manager_getx/ui/screen/sign_in_screen.dart';
import 'package:task_manager_getx/ui/widgets/screen_bg.dart';
import '../controllers/auth_controller/pin_verification_controller.dart';
import '../utils/app_colors.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});
  static const String name = '/PinVerificationScreen';

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    final PinVerificationController controller = Get.find<PinVerificationController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: ScreenBackground(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: GetBuilder<PinVerificationController>(
              builder: (controller) {
                return SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Pin Verification",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "A 6 Digit verification pin will be sent to your\nemail address.",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 32),

                        // PIN Code Input
                        PinCodeTextField(
                          appContext: context,
                          backgroundColor: Colors.transparent,
                          length: 6,
                          controller: _pinController,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          keyboardType: TextInputType.number,
                          autoFocus: true,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(10),
                            fieldHeight: 55,
                            fieldWidth: 50,
                            activeColor: AppColors.themeColor,
                            inactiveColor: Colors.white,
                            selectedColor: AppColors.themeColor,
                            activeFillColor: Colors.white,
                            inactiveFillColor: Colors.white,
                            selectedFillColor: Colors.white,
                          ),
                          enableActiveFill: true,
                          onChanged: (value) {},
                          onCompleted: (value) {

                          },
                        ),
                        const SizedBox(height: 30),

                        // Submit Button or Loader
                        Visibility(
                          visible: !_inProgress,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton (
                            onPressed: () {

                              Get.toNamed(SetPasswordScreen.name);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.themeColor,
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            child: const Icon(
                              Icons.arrow_circle_right_outlined,
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
                      ],
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
