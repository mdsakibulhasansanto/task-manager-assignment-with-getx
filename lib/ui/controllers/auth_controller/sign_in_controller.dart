
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/user_models.dart';
import '../../../data/services/network_caller.dart';

import '../../../data/urls/user_auth.dart';
import 'auth_controllers.dart';


class SignInController extends GetxController {
  final RxBool inProgress = false.obs;
  final RxString errorMessage = ''.obs;

  Future<bool> signIn(String email, String password) async {
    inProgress.value = true;
    errorMessage.value = '';
    bool isSuccess = false;

    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };

    final response = await NetworkCaller.postRequest(
      url: Urls.loginUrl,
      body: requestBody,
    );

    if (response.isSuccess && (response.responseData?['status']?.toString().toLowerCase() == 'success')) {
      try {
        final token = response.responseData?['token'];
        if (token != null) {
          UserModel userModel = UserModel.fromJson(response.responseData!);
          await AuthController.saveUserData(token, userModel);
          debugPrint('User data saved successfully: ${userModel.toJson()}');

          isSuccess = true;
          errorMessage.value = '';

          Get.snackbar('Success', 'Login successfully',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white);
        } else {
          errorMessage.value = 'Token missing in response';
        }
      } catch (e) {
        debugPrint('Error parsing user model: $e');
        errorMessage.value = 'Something went wrong';
      }
    } else {
     final String error = errorMessage.value = response.responseData?['message'] ?? 'Login failed';
      Get.snackbar( 'Error : ', error,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    }

    inProgress.value = false;
    return isSuccess;
  }

}
