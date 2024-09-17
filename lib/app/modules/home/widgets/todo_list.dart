import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_reminder/app/core/values/colors.dart';
import 'package:task_reminder/app/modules/home/controller.dart';

class TodoList extends StatelessWidget {
  TodoList({Key? key}) : super(key: key);
  final homeCtrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
    homeCtrl.newTodos.isEmpty && homeCtrl.doneTodos.isEmpty ? Column(
      children: [
        Image.asset('assets/images/task.jpg',
          fit: BoxFit.cover,
          width: 80,
        ),
        const SizedBox(height: 20.0),
        const Text('Add Tasks',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ],
    ) : ListView(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      children: [
        ...homeCtrl.newTodos.map((element) =>
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                  children: [
                    SizedBox(
                      width: 20, height: 20,
                      child: Checkbox(
                        fillColor: MaterialStateProperty.resolveWith((
                            states) => Colors.grey),
                        value: element['done'],
                        onChanged: (bool? value) {
                          homeCtrl.doneTodoTasks(element['title']);
                        },
                      ),
                    ),
                    const SizedBox(width: 10.0,),
                    Text(element['title'], overflow: TextOverflow.ellipsis,)
                  ]),
            ),).toList(),
        if(homeCtrl.newTodos.isNotEmpty)
          const Divider(thickness: 2, indent: 40,),
        if(homeCtrl.doneTodos.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Text('Completed (${homeCtrl.doneTodos.length})',
                style: const TextStyle(color: Colors.black38, fontSize: 20)),
          ),
        ...homeCtrl.doneTodos.map((element) =>
            Dismissible(
              key: ObjectKey(element),
              direction: DismissDirection.endToStart,
              onDismissed: (_) => homeCtrl.deleteDoneTasks(element),
              background: Container(
                color: Colors.red.withOpacity(0.8),
                alignment: Alignment.centerRight,
                  child: const Padding(
                    padding:  EdgeInsets.only(right: 8.0),
                    child:  Icon(Icons.delete,color: Colors.white),
                  ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.done, color: purple.withOpacity(0.8), size: 26,),
                    const SizedBox(width: 10.0,),
                    Text(element['title'],
                      style: const TextStyle(fontSize: 22, color: Colors
                          .black38, decoration: TextDecoration.lineThrough),)
                  ],
                ),
              ),
            ),).toList(),
      ],
    )
    );
  }
}