
 import 'package:get/get.dart';
import 'package:task_manager_getx/ui/controllers/task_controller/new_task_list_controller.dart';
import 'package:task_manager_getx/ui/controllers/task_controller/task_add_controller.dart';
import '../auth_controller/email_verification_controller.dart';
import '../auth_controller/pin_verification_controller.dart';
import '../auth_controller/set_password_controller.dart';
import '../auth_controller/sign_in_controller.dart';
import '../auth_controller/sign_up_controller.dart';


class BinderControllers extends Bindings {
  @override
  void dependencies() {

    // Auth Controllers
    Get.put(SignUpController());
    Get.put(SignInController());
    Get.put(EmailVerifyController());
    Get.put(PinVerificationController());
    Get.put(SetPasswordController());

    // Task Controllers
    Get.put(TaskAddController());
    Get.put(TaskListController());
  }

}