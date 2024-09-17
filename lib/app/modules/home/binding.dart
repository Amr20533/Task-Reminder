import 'package:get/get.dart';
import 'package:task_reminder/app/data/providers/task/provider.dart';
import 'package:task_reminder/app/data/services/services_storage/repository.dart';
import 'package:task_reminder/app/modules/home/controller.dart';

class HomeBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(taskRepository: TaskRepository(
      taskProvider: TaskProvider(),
    )));
  }
}