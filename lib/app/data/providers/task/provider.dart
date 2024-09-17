import 'dart:convert';

import 'package:get/get.dart';
import 'package:task_reminder/app/core/utils/keys.dart';
import 'package:task_reminder/app/data/models/task.dart';
import 'package:task_reminder/app/data/services/services_storage/services.dart';

class TaskProvider {
  StorageService storage = Get.find<StorageService>();
  //
  // {
  ///   'tasks':[
  // {'title' : 'work',
  // 'color' : '#ff123456',
  // 'icon': 0xe123
  // }
  //   ]}

  List<Task> readTasks (){
    var tasks = <Task>[];
    jsonDecode(storage.read(taskKey).toString()).forEach((element) => tasks.add(Task.fromJson(element)));
    return tasks;
  }

  void writeTasks(List<Task> tasks){
    storage.write(taskKey, jsonEncode(tasks));
  }
}