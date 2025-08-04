import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/ui/widgets/custom_app_bar.dart';
import 'package:task_manager_getx/ui/widgets/input_from_filed.dart';
import 'package:task_manager_getx/ui/widgets/screen_bg.dart';

import '../../data/models/user_profile_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/urls/user_auth.dart';
import '../controllers/auth_controller/auth_controllers.dart';
import '../controllers/task_controller/task_add_controller.dart';
import '../utils/app_colors.dart';

class TaskAddScreen extends StatefulWidget {
  const TaskAddScreen({super.key});

  static const String routeName = '/task_add_screen';

  @override
  State<TaskAddScreen> createState() => _TaskAddScreenState();
}

class _TaskAddScreenState extends State<TaskAddScreen> {
  UserProfileModel? _userProfile;

  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDescriptionController = TextEditingController();
  final TaskAddController taskAddController = Get.find<TaskAddController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _inProgress = false;

  @override
  void initState() {
    super.initState();
    profileDataGet();
  }

  @override
  Widget build(BuildContext context) {
    String firstName = _userProfile?.data?.first.firstName ?? '';
    String lastName = _userProfile?.data?.first.lastName ?? '';
    String fullName = '$firstName $lastName';
    String email = _userProfile?.data?.first.email ?? '';
    String id = _userProfile?.data?.first.id ?? '';

    return Scaffold(
      appBar: CustomAppBar(email: email, fullName: fullName, id: id),
      resizeToAvoidBottomInset: true,
      body: ScreenBackground(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 34),
                  Text(
                    'Add New Task',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  InputFromFiled(
                    controller: taskTitleController,
                    hint: 'Task Title',

                  ),
                  const SizedBox(height: 16),
                  buildInputDescriptionField(
                    controller: taskDescriptionController,
                    hint: 'Task Description',
                  ),
                  const SizedBox(height: 34),
                  // Sign Up Button
                  Visibility(
                    visible: !_inProgress,
                    replacement: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: AppColors.themeColor,
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {

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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> profileDataGet() async {
    print("Using token: ${AuthController.accessToken}");

    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.profileDetailsUrl,
      headers: {
        'Content-Type': 'application/json',
        'token': AuthController.accessToken!,
      },
    );

    if (response.isSuccess) {
      setState(() {
        _userProfile = UserProfileModel.fromJson(response.responseData!);
      });
    } else {
      print("Failed to fetch profile data");
      print("Status: ${response.statusCode}");
      print("Response: ${response.responseData}");
    }
  }
}

Widget buildInputDescriptionField({
  required TextEditingController controller,
  required String hint,
}) {
  return SizedBox(
    height: 250,
    child: TextFormField(
      controller: controller,
      maxLines: 100,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,

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
