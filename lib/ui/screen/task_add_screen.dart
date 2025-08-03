import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/ui/widgets/input_from_filed.dart';

import '../controllers/task_controller/task_add_controller.dart';
import '../utils/app_colors.dart';


class TaskAddScreen extends StatefulWidget {
  const TaskAddScreen({super.key});
  static const String routeName = '/task_add_screen';

  @override
  State<TaskAddScreen> createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDescriptionController = TextEditingController();
  final TaskAddController taskAddController = Get.find<TaskAddController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: AppColors.bgColor,
          child: Column(
            children: [

              // Title Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Get.back();
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.themeColor,
                        child: Icon(Icons.arrow_back_ios_new, size: 18),
                      ),
                    ),
                    const SizedBox(width: 0),
                    const Expanded(
                      child: Text(
                        'Add Task',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                  ],
                ),
              ),

              // Task Form Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            const Text(
                              'Task title',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 5),
                            InputFromFiled(
                              controller: taskTitleController,
                              hint: 'title',
                            ),

                            const SizedBox(height: 10),
                            const Text(
                              'Task description',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 5),
                            buildInputDescriptionField(
                              controller: taskDescriptionController,
                              hint: 'Include logo, navigation, CTA button...',
                            ),

                            const SizedBox(height: 20),

                            // Submit Button or Loader
                            Obx(() => taskAddController.inProgress.value
                                ? const Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.green,
                              ),
                            )
                                : ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  taskAddController.addTask(
                                    taskTitleController.text.trim(),
                                    taskDescriptionController.text.trim(),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.themeColor,
                              ),
                              child: const Text(
                                'Save Task',
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable description input field
Widget buildInputDescriptionField({
  required TextEditingController controller,
  required String hint,
}) {
  return SizedBox(
    height: 200,
    child: TextFormField(
      controller: controller,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a description';
        }
        return null;
      },
    ),
  );
}
