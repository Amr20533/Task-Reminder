import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_reminder/app/core/utils/extensions.dart';
import 'package:task_reminder/app/core/values/colors.dart';
import 'package:task_reminder/app/modules/home/controller.dart';

class AddDialog extends StatelessWidget {
  AddDialog({Key? key}) : super(key: key);
  final homeCtrl = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body:Form(
          key:homeCtrl.formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                    onPressed: (){
                      Get.back();
                      homeCtrl.editController.clear();
                      homeCtrl.changeTaskCategory(null);
                    },
                      icon:const Icon(Icons.close),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(Colors.transparent)
                      ),
                      onPressed: (){
                        if(homeCtrl.formKey.currentState!.validate()){
                          if(homeCtrl.task.value == null){
                            EasyLoading.showError('Please Select a task type');
                          }else{
                            var success = homeCtrl.updateTask(
                            homeCtrl.task.value!,
                            homeCtrl.editController.text);
                            if(success){
                              EasyLoading.showSuccess('Todo item add success');
                              Get.back();
                              homeCtrl.changeTaskCategory(null);
                            }else{
                              EasyLoading.showError(' Todo item already exist');
                            }
                          }
                        }
                      },
                      child:const Text('Done',style:TextStyle(fontSize: 20,color:purple)),
                    )
                    ],
                ),
              ),
              const Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text('New Task',style:TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 7.0),
                child: TextFormField(
                  controller: homeCtrl.editController,
                  decoration: InputDecoration(
                    // hintText: 'Type in Something...',
                    // hintStyle: const TextStyle(
                    //   color: Colors.black26
                    // ),
                    focusedBorder:  UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!)
                    )
                  ),
                  autofocus: true,
                    validator: (value){
                    if(value == null || value.trim().isEmpty){
                      return 'required';
                    }
                    return null;
                    },
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10.0),
              child: Text('Add to',style:TextStyle(color: Colors.black26,fontSize: 18)),
              ),
              ...homeCtrl.tasks.map((element) => Obx(
                    () => InkWell(
                  onTap: () => homeCtrl.changeTaskCategory(element),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 7.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(IconData(element.icon,fontFamily: 'MaterialIcons'),
                              color: HexColor.fromHex(element.color),
                            ),
                            const SizedBox(width: 7.0,),
                            Text(element.title,style:const TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                          ],
                        ),
                        if(homeCtrl.task.value == element)
                          const Icon(Icons.check,color: Colors.blue,)
                    ],),
                  ),
                ),
              )).toList()
            ],
          ),
        )
      ),
    );
  }
}
