
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/data/urls/task_urls.dart';

import '../../../data/models/task_model.dart';
import '../../../data/services/network_caller.dart';
import '../auth_controller/auth_controllers.dart';

class TaskListController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  List<TaskModel> _newTaskList = [];

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;
  List<TaskModel> get newTaskList => _newTaskList;


  Future<bool> fetchTasks() async {
    bool isSuccess = false;

    _inProgress = true;
    update();

    debugPrint('Task list urls : ${TaskUrls.getNewTasksUrl}');
    NetworkResponse networkResponse = await NetworkCaller.getRequest(
        url: TaskUrls.getNewTasksUrl,

        headers: {
          'Content-Type': 'application/json',
          'token': AuthController.accessToken!,
        },


    );

    if (networkResponse.isSuccess) {
      final tasksJsonList = networkResponse.responseData?['data'] as List;
      debugPrint('tasksJsonList : $tasksJsonList');
      _newTaskList = tasksJsonList.map((e) => TaskModel.fromJson(e)).toList();

      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = networkResponse.errorMessage ??
          networkResponse.responseData?['message'] ??
          'Failed to fetch tasks.';
    }


    _inProgress = false;
    update();

    return isSuccess;
  }
}
