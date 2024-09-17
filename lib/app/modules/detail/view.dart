import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:task_reminder/app/core/utils/extensions.dart';
import 'package:task_reminder/app/core/values/colors.dart';
import 'package:task_reminder/app/modules/home/controller.dart';
import 'package:task_reminder/app/modules/home/widgets/todo_list.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({Key? key}) : super(key: key);
  final homeCtrl = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.task.value;
    var color = HexColor.fromHex(task!.color);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body:Form(
          key: homeCtrl.formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left:10.0,bottom: 16,top: 10),
                child: Row(
                  children: [
                    IconButton(onPressed: (){
                      Get.back();
                      homeCtrl.updateTodoTask();
                      homeCtrl.changeTaskCategory(null);
                      homeCtrl.editController.clear();
                    },
                        icon:const Icon(Icons.arrow_back_ios,size: 20,color: purple,))
                  ],
                ),

              ),
              // icon & title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Icon(IconData(task.icon, fontFamily: 'MaterialIcons'),color:color),
                    const SizedBox(width: 12,),
                    Text(task.title,style:const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),)
                  ],
                ),
              ),
              // total tasks & step progress indicator
              Obx(() {
                var totalTasks = homeCtrl.newTodos.length + homeCtrl.doneTodos.length;
                return Padding(
                  padding: const EdgeInsets.only(left: 55,right: 55,top: 15.0),
                  child: Row(
                    children: [
                      Text(
                        totalTasks < 10 && totalTasks >=1?
                        '0$totalTasks Task':'$totalTasks Tasks',style:const TextStyle(
                          color: Colors.black38,
                          fontSize: 18
                      ),),
                      const SizedBox(width: 15,),
                      Expanded(
                        child: StepProgressIndicator(
                          totalSteps: totalTasks == 0 ? 1 : totalTasks,
                          currentStep: homeCtrl.doneTodos.length,
                          size:5,
                          padding: 0,
                            selectedGradientColor: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [color.withOpacity(0.5),color],
                            ),
                            unselectedGradientColor: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.grey[300]!,Colors.grey[300]!],
                            ),
                        ),
                      )
                    ],
                  ),
                );
              }
              ),
              // text form field with check box
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 3),
                child: TextFormField(
                  controller: homeCtrl.editController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                    prefixIcon: IconButton(
                      onPressed:() {},
                      icon:const Icon(Icons.check_box_outline_blank),

                    ),
                    suffixIcon: IconButton(
                      onPressed:(){
                        if(homeCtrl.formKey.currentState!.validate()){
                          var success = homeCtrl.addTodoTask(homeCtrl.editController.text);
                          if(success){
                            EasyLoading.showSuccess('Todo item added successfully');
                          }else{
                            EasyLoading.showError('Todo item already exist!');
                            }
                          homeCtrl.editController.clear();
                        }
                      },
                      icon: const Icon(Icons.done),
                    )
                  ),
                  validator: (value){
                    if(value == null || value.trim().isEmpty){
                      return 'Please Enter your todo item';
                    }
                    return null;
                  },
                  autofocus: true,
                ),
              ),
              TodoList(),
            ],
          ),
        ),
        // bottomNavigationBar: Container(
        //   height: 120,
        //   color: Colors.blueAccent,
        //   child: Stack(alignment: AlignmentDirectional.topCenter,
        //     clipBehavior: Clip.none,
        //     children: [
        //       Container(width: 80,height: 80,
        //         decoration:BoxDecoration(
        //           shape: BoxShape.circle,
        //           color: Colors.purple
        //         ),
        //         child: Icon(Icons.add,color:Colors.white),
        //
        //       ),
        //       Align(
        //         alignment: Alignment.bottomCenter,
        //         child:Container(
        //           padding:const EdgeInsets.symmetric(horizontal: 20),
        //           height: 80,
        //           decoration: BoxDecoration(
        //               color: Colors.white,
        //               boxShadow: [BoxShadow(
        //                   color: Colors.grey[300]!,
        //                   blurRadius: 7,
        //                   offset: Offset(-5,0)
        //               )]
        //           ),
        //           child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               IconButton(onPressed: (){},
        //                   icon: Icon(Icons.menu,size: 28,color: Colors.black45)),
        //               IconButton(onPressed: (){},
        //                   icon: Icon(Icons.more_horiz,size: 28,color: Colors.black45,))
        //             ],
        //           ),
        //         ),
        //
        //       )
        //     ],
        //   ),
        // )
      ),
    );
  }
}
/*
* Container(
        padding:const EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 7,
            offset: Offset(-5,0)
          )]
        ),
        child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: (){},
                icon: Icon(Icons.menu,size: 28,color: Colors.black45)),
            IconButton(onPressed: (){},
                icon: Icon(Icons.more_horiz,size: 28,color: Colors.black45,))
          ],
        ),
      ),*/