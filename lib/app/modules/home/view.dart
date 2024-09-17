import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_reminder/app/core/values/colors.dart';
import 'package:task_reminder/app/data/models/task.dart';
import 'package:task_reminder/app/modules/home/Report/view.dart';
import 'package:task_reminder/app/modules/home/controller.dart';
import 'package:task_reminder/app/modules/home/widgets/add_card.dart';
import 'package:task_reminder/app/modules/home/widgets/add_dialog.dart';
import 'package:task_reminder/app/modules/home/widgets/task_card.dart';
class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Obx(() => IndexedStack(
          index: controller.curTab.value,
          children: [
            SafeArea(
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('My List',style: TextStyle(color:Colors.black,fontSize: 24.0,fontWeight: FontWeight.bold),),
                  ),
                  Obx(() => GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      // TaskCard(
                      //   task: Task(
                      //     title: 'title',
                      //     icon: 0xe59c,
                      //     color:'#fffffffffff',
                      //   ),
                      // ),
                      ...controller.tasks.map((element) => LongPressDraggable(
                          data: element,
                        onDragStarted: () => controller.chooseDeletedItem(true),
                          onDraggableCanceled: (_,__) => controller.chooseDeletedItem(false),
                          onDragEnd: (_) => controller.chooseDeletedItem(false),
                          feedback: Opacity(opacity: 0.8,
                            child: SizedBox(
                                width: 200,height: 200,
                                child: TaskCard(task: element,)),),
                          child: TaskCard(task: element))).toList(),

                      AddCard(),
                    ],
                  )),
                ],
              ),

            ),
            ReportScreen(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
          onTap:(int index) => controller.changeCurTab(index),
          currentIndex: controller.curTab.value,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          items:const [
            BottomNavigationBarItem(icon: Padding(
              padding:  EdgeInsets.only(right:70.0),
              child:  Icon(Icons.apps),
            ),label: 'Home'),
            BottomNavigationBarItem(icon: Padding(
              padding:  EdgeInsets.only(left:70.0),
              child:  Icon(Icons.more_horiz),
            ),label: 'More'),
          ]
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: DragTarget(
        builder: (BuildContext context,_,__) {
          return Obx(() => FloatingActionButton(
            onPressed: () => Get.to(() => AddDialog(), transition: Transition.downToUp),
            backgroundColor: controller.deleting.value ? Colors.redAccent : purple,
            child:Icon(controller.deleting.value ? Icons.delete: Icons.add, color: Colors.white,),
          ),
          );
        },
        onAccept: (Task task){
          controller.deleteTask(task);
          EasyLoading.showSuccess('DELETE SUCCESS');
        },
      ),
    );
  }
}
