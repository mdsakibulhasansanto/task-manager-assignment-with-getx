import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller/new_task_list_controller.dart';
import '../utils/app_colors.dart';
import '../widgets/task_card.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {

  final TaskListController _taskListController = Get.find<TaskListController>();

  @override
  void initState() {
    super.initState();
    _taskListController.fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color: AppColors.bgColor,
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GetBuilder<TaskListController>(
            builder: (controller) {
              if (controller.inProgress) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.errorMessage != null) {
                return Center(child: Text(controller.errorMessage!));
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 17,vertical: 2),
                    child: Text(
                      'My Tasks',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: ListView.separated(
                      itemCount: controller.newTaskList.length,
                      separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final task = controller.newTaskList[index];
                        return GestureDetector(
                          onTap: () {
                            Map<String,dynamic > taskData = {
                              'taskId': ?task.id,
                              'title': ?task.title,
                              'description': ?task.description,
                            };
                           // Get.toNamed(TaskDetails.name, arguments: taskData);
                          },
                          child: TaskCard(taskModel: task),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
