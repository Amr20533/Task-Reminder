import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_reminder/app/core/utils/extensions.dart';
import 'package:task_reminder/app/data/models/task.dart';
import 'package:task_reminder/app/modules/home/controller.dart';
import 'package:task_reminder/app/widgets/icons.dart';

class AddCard extends StatelessWidget {
   AddCard({Key? key}) : super(key: key);
  final homeCtrl = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    // List<int> icn =[
    //   0xe491,
    //   0xe11c,0xe40f,0xe4dc,0xe071,0xe59c
    // ];
    // List<IconData> icn =[
    //   Icons.person,
    //   Icons.work_outline_rounded,
    //   Icons.tv_outlined,
    //   Icons.sports_martial_arts_outlined,
    //   Icons.card_travel,
    //   Icons.shopping_cart_checkout_outlined
    // ];
    Path customPath = Path()
      ..moveTo(20, 20)
      ..lineTo(50, 100)
      ..lineTo(20, 200)
      ..lineTo(100, 100)
      ..lineTo(20, 20);
    final icons = getIcons();
    return Container(
      width: MediaQuery.of(context).size.width /2.5,
      height: MediaQuery.of(context).size.height / 2.5,
      margin:const EdgeInsets.all(30),
      child:InkWell(
        onTap:()async{
          await Get.defaultDialog(
            titlePadding:const EdgeInsets.symmetric(vertical: 5.0),
            radius: 5,
            title: 'Task Type',
            content: Form(
              key: homeCtrl.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: homeCtrl.editController,
                      decoration:const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title'
                      ),
                      validator: (value){
                        if(value == null || value.trim().isEmpty){
                          return 'required';
                        }
                        return null;

                      },
                    ),
                  ),
                  Wrap(
                    spacing:50,
                    children: icons.map((e)=> Obx((){
                      final index = icons.indexOf(e);
                      return ChoiceChip(
                        selectedColor: Colors.grey[200],
                        pressElevation: 0,
                        backgroundColor: Colors.white,
                        label: e,
                          selected: homeCtrl.chipIndex.value == index,
                          onSelected: (bool selected){
                            homeCtrl.chipIndex.value = selected? index : 0;
                          },
                      );
                    })).toList(),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // primary: blue,
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                          minimumSize: const Size(150,40),
                      ),
                      onPressed: (){
                        if(homeCtrl.formKey.currentState!.validate()){
                            int icon = icons[homeCtrl.chipIndex.value].icon!.codePoint;
                            // IconData icon = icn[homeCtrl.chipIndex.value];
                            String color = icons[homeCtrl.chipIndex.value].color!.toHex();
                            var task = Task(
                              title:homeCtrl.editController.text,
                              icon: icon,
                              color: color,
                            );
                            Get.back();
                            homeCtrl.addTask(task)? EasyLoading.showSuccess('Create success') : EasyLoading.showError('Duplicated Task!');
                        }
                      },
                      child: const Text('Confirm'))
                ],
              ),),

          );
          homeCtrl.editController.clear();
          homeCtrl.changeChipIndex(0);
        },
        child: DottedBorder(
          // customPath: (size) => customPath, // PathBuilder
          color: Colors.grey[400]!,
          dashPattern:const [8, 4],
          // strokeWidth: 2,
          child:const Center(
            child: Icon(Icons.add,size:30,
            color: Colors.grey,),
          ),
        ),
      )
    );
  }
}
