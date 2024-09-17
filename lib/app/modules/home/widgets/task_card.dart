import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:task_reminder/app/core/utils/extensions.dart';
import 'package:task_reminder/app/data/models/task.dart';
import 'package:task_reminder/app/modules/detail/view.dart';
import 'package:task_reminder/app/modules/home/controller.dart';

class TaskCard extends StatelessWidget {
  TaskCard({required this.task,Key? key}) : super(key: key);
  final homeCtrl = Get.find<HomeController>();
  final Task task;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final color = HexColor.fromHex(task.color);
    return GestureDetector(
      onTap: (){
        homeCtrl.changeTaskCategory(task);
        homeCtrl.chooseTodos(task.todos ?? []);
        Get.to(() => DetailScreen());
      },
      child: Container(
        width: size.width/2 - 20,
        height: size.height/2 -20 ,
        margin:const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 7,
              offset:const Offset(0, 7),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              StepProgressIndicator(
                // TODO: change after finish todo CRUD
                totalSteps: homeCtrl.isEmptyTask(task) ? 1 : task.todos!.length,
                currentStep: homeCtrl.isEmptyTask(task) ? 0 : homeCtrl.getDoneTask(task),
                size: 5,
                padding: 0,
                selectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withOpacity(0.5),color],
                ),
                unselectedGradientColor:const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white,Colors.white],
                ),
              ),
              // task category icon
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(IconData(task.icon,fontFamily: 'MaterialIcons'),color: color,),
              ),
              const SizedBox(height: 20.0,),
              // category name and number of tasks
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(task.title,style:const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),overflow: TextOverflow.ellipsis,),
                    const SizedBox(height: 7.0,),
                    Text('${task.todos?.length ?? 0} Task',
                    style:const TextStyle(fontWeight: FontWeight.bold,color:Colors.grey),
                    ),
                  ],
                ),
              )
            ],
        ),
      ),
    );
  }
}
