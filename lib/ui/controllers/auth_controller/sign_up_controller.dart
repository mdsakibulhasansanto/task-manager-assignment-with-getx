

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/data/urls/user_auth.dart';

import '../../../data/services/network_caller.dart';

class SignUpController extends GetxController {
  final String _baseUrl = Urls.registrationUrl;

  Future<void> signUp({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    required String mobile,
  }) async {
    final url = _baseUrl;

    final response = await NetworkCaller.postRequest(
      url: url,
      body: {
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'password': password,
        'mobile': mobile,
      },
    );

    if (response.isSuccess) {
      Get.snackbar('Success', 'SignUp successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } else {

      Get.snackbar('Error : ${response.errorMessage}', response.responseData!['data'] ?? 'Failed to sign up' ,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}