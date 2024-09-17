import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_reminder/app/data/models/task.dart';
import 'package:task_reminder/app/data/services/services_storage/repository.dart';

class HomeController extends GetxController{
  TaskRepository taskRepository;

  HomeController({required this.taskRepository});
  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final chipIndex = 0.obs;
  final curTab = 0.obs;
  final deleting = false.obs;
  final tasks = <Task>[].obs;
  final task = Rx<Task?>(null);
  final newTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;

  @override
  void onInit(){
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    editController.dispose();
    super.onClose();
  }
  void chooseTodos(List<dynamic> select){
    newTodos.clear();
    doneTodos.clear();
    for (int i = 0;i < select.length; i++){
      var todo = select[i];
      var status = todo['done'];
      if(status == true){
        doneTodos.add(todo);
      }else{
        newTodos.add(todo);
      }
    }
  }
  void chooseDeletedItem(bool value){
    deleting.value = value;
  }
  void changeChipIndex(int index){
    chipIndex.value = index;
  }
  void changeTaskCategory(Task? selectedTask){
    task.value = selectedTask;
  }
  // add new category
  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  void changeCurTab(int index){
    curTab.value = index;
  }

  // delete category task
  void deleteTask(Task task){
    tasks.remove(task);
  }
  // update task categories
  bool updateTask(Task task, String title){
    var todos = task.todos ?? [];
    if(containTodo(todos, title)){
      return false;
    }
    var todo = {'title':title, 'done':false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldId = tasks.indexOf(task);
    tasks[oldId] = newTask;
    tasks.refresh();
    return true;
  }
  // check for existing tasks
  bool containTodo(List todos,String title){
    return todos.any((element) => element['title'] == title);
  }
  // add new task to todo task list
  bool addTodoTask(String title){
    var todo = {'title': title, 'done': false};
    var doneTodo = {'title': title, 'done': true};
    if(newTodos.any((element) => mapEquals<String,dynamic>(todo, element)) || doneTodos.any((element) => mapEquals<String,dynamic>(doneTodo,element))){
      return false;
    }
    newTodos.add(todo);
    return true;
  }
  // update edited task
  void updateTodoTask(){
    var newTodoTask = <Map<String,dynamic>>[];
    newTodoTask.addAll([
      ...newTodos, ...doneTodos
    ]);
    var nTasks = task.value!.copyWith(todos: newTodoTask);
    int oldId = tasks.indexOf(task.value);
    tasks[oldId] = nTasks;
    tasks.refresh();
  }

  void doneTodoTasks(String title) {
    var doneTask = {'title':title,'done':false};
    int cur = newTodos.indexWhere((element) => mapEquals<String,dynamic>(doneTask,element));
    newTodos.removeAt(cur);
    var done = {'title': title, 'done': true};
    doneTodos.add(done);
    newTodos.refresh();
    doneTodos.refresh();
  }
  // to delete done tasks
  deleteDoneTasks(dynamic doneTask) {
    int cur = doneTodos.indexWhere((element) => mapEquals(doneTask,element));
    doneTodos.removeAt(cur);
    doneTodos.refresh();
  }
  // to check that todos list [] is not empty
  bool isEmptyTask(Task task){
    return task.todos == null || task.todos!.isEmpty;
  }
  // to get done tasks
  int getDoneTask(Task task){
    var result = 0;
    for(int i = 0; i < task.todos!.length; i++){
      if(task.todos![i]['done'] == true){
        result += 1;
      }
    }
    return result;
  }
  // to get total done tasks
  int getTotalDoneTask(){
    var result = 0;
    for(int i = 0; i < tasks.length; i++){ // don't use done todos length not a correct option to detect the todos length in all task categories
      if(tasks[i].todos != null){
        for(int j = 0; j < tasks[i].todos!.length; j++){
          if(tasks[i].todos![j]['done'] == true){
            result += 1;
          }
        }
      }
    }
    return result;
  }
  // get total tasks
  int getTotalTasks(){
    var result = 0;
    for(int i = 0; i < tasks.length; i++ ){
      if(tasks[i].todos != null){
        result += tasks[i].todos!.length;
      }
    }
    return result;
  }
}