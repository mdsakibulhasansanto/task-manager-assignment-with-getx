import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/data/urls/task_urls.dart';

import '../../../data/services/network_caller.dart';
import '../auth_controller/auth_controllers.dart';


class TaskAddController extends GetxController {
  final RxBool inProgress = false.obs;

  Future<void> addTask(String title, String description) async {
    try {
      inProgress.value = true;

      debugPrint(' Adding Task: $title - $description');

      Map<String, String> taskData = {
        'title': title,
        'description': description,
      };

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization' : 'Bearer ${AuthController.accessToken}',
      };

      NetworkResponse response = await NetworkCaller.postRequest(
        url: TaskUrls.createNewTaskUrl,
        body: taskData,
        headers: headers,
      );

      if (response.isSuccess) {
        debugPrint('Task added successfully');
        Get.snackbar('Success', 'Task added successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } else {
        debugPrint('Failed to add task: ${response.responseData}');
        Get.snackbar('Error', 'Failed to add task',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      debugPrint(' Exception: $e');
      Get.snackbar('Error', 'Something went wrong',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      inProgress.value = false;
    }
  }
}
