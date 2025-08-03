import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager_getx/data/urls/task_urls.dart';
import 'package:task_manager_getx/ui/screen/task_add_screen.dart';

import '../../data/models/task_model.dart';
import '../../data/models/task_status_count_model.dart';
import '../../data/services/network_caller.dart';
import '../widgets/centered_circular_progress_indicator.dart';
import '../widgets/show_snack_bar.dart';
import '../widgets/task_card.dart';
import '../widgets/task_count_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTasksInProgress = false;
  bool _getTaskStatusCountInProgress = false;
  List<TaskModel> _newTaskList = [];
  List<TaskStatusCountModel> _taskStatusCountList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getNewTaskList();
      _getTaskStatusCountList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: Visibility(
                visible: _getTaskStatusCountInProgress == false,
                replacement: CenteredCircularProgressIndicator(),
                child: ListView.separated(
                  itemCount: _taskStatusCountList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return TaskCountSummaryCard(
                      title: _taskStatusCountList[index].id,
                      count: _taskStatusCountList[index].count,
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(width: 4),
                ),
              ),
            ),
            Expanded(
              child: Visibility(
                visible: _getNewTasksInProgress == false,
                replacement: CenteredCircularProgressIndicator(),
                child: ListView.builder(
                  itemCount: _newTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      taskType: TaskType.tNew,
                      taskModel: _newTaskList[index],
                      onStatusUpdate: () {
                        _getNewTaskList();
                        _getTaskStatusCountList();
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Get.toNamed(TaskAddScreen.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _getNewTaskList() async {
    _getNewTasksInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller
        .getRequest(url: TaskUrls.getNewTasksUrl);

    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData!['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _newTaskList = list;
    } else {
      if (mounted) {
        showSnackBarMessage(context, response.errorMessage!);
      }
    }

    _getNewTasksInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _getTaskStatusCountList() async {
    _getTaskStatusCountInProgress = true;
    setState(() {});

    NetworkResponse response = await NetworkCaller
        .getRequest(url: TaskUrls.getTaskStatusCountUrl);

    if (response.isSuccess) {
      List<TaskStatusCountModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData!['data']) {
        list.add(TaskStatusCountModel.fromJson(jsonData));
      }
      _taskStatusCountList = list;
    } else {
      if (mounted) {
        showSnackBarMessage(context, response.errorMessage!);
      }
    }

    _getTaskStatusCountInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }


}