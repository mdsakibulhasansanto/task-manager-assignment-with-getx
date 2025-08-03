import 'package:flutter/material.dart';
import 'package:task_manager_getx/data/models/user_profile_model.dart';
import 'package:task_manager_getx/data/services/network_caller.dart';
import 'package:task_manager_getx/ui/controllers/auth_controller/auth_controllers.dart';
import 'package:task_manager_getx/ui/screen/cancelled_screen.dart';
import 'package:task_manager_getx/ui/screen/completed_screen.dart';
import 'package:task_manager_getx/ui/screen/new_task_screen.dart';
import 'package:task_manager_getx/ui/screen/progress_screen.dart';
import 'package:task_manager_getx/ui/widgets/custom_app_bar.dart';

import '../../data/urls/user_auth.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  static String name = '/DashBoardScreen';

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  UserProfileModel? _userProfile;
  final List<Widget> _screens = [
    NewTaskScreen(),
    ProgressScreen(),
    CompletedScreen(),
    CancelledScreen(),
  ];

  int _selectedIndex = 0;

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
      appBar: CustomAppBar(fullName: fullName, email: email, id: id),
      body:  _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          _selectedIndex = index;
          setState(() {});
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.new_label_outlined),
            label: 'New',
          ),
          NavigationDestination(
            icon: Icon(Icons.arrow_circle_right_outlined),
            label: 'Progress',
          ),
          NavigationDestination(icon: Icon(Icons.done), label: 'Completed'),
          NavigationDestination(icon: Icon(Icons.close), label: 'Cancelled'),
        ],
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
