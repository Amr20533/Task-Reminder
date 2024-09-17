import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:task_reminder/app/core/values/colors.dart';
import 'package:task_reminder/app/modules/home/controller.dart';
import 'package:task_reminder/app/modules/home/widgets/weekly_report_chart.dart';

class ReportScreen extends StatelessWidget {
  ReportScreen({Key? key}) : super(key: key);
  final homeCtrl = Get.find<HomeController>();
  final formattedDate = DateFormat.yMMMMd().format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Obx((){
          var createdTasks = homeCtrl.getTotalTasks();
          var completedTasks = homeCtrl.getTotalDoneTask();
          var freshTasks = createdTasks - completedTasks;
          var percent = (completedTasks / createdTasks * 100).toStringAsFixed(0);
          return ListView(
            children: [
              Padding(padding:const EdgeInsets.all(20.0),
                child:Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('My Report',
                        style:TextStyle(fontSize: 26,fontWeight: FontWeight.bold)),
                    Row(
                      children:const [
                        Text('this Month',
                            style:TextStyle(fontSize: 18,color: Colors.black45)),
                        Icon(Icons.keyboard_arrow_down,color: Colors.grey,),
                      ],
                    )
                    // DropdownButton(
                    //   icon:const Icon(Icons.keyboard_arrow_down,color: Colors.grey,),
                    //   iconSize: 32,elevation: 4,
                    //   style: TextStyle(fontSize: 18),
                    //   items: remindList.map<DropdownMenuItem<String>>((int value){
                    //     return DropdownMenuItem<String>(
                    //       value: value.toString(),
                    //       child: Text(value.toString()),
                    //     );
                    //   }).toList(),
                    //   underline: Container(height: 0,),
                    //   onChanged: (String? value) {
                    //     setState(() {
                    //       _selectReminder = int.parse(value!);
                    //     });
                    //   },
                    //
                    // )
                  ],
                ),),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(formattedDate,style:const TextStyle(fontSize:18,color: Colors.black38 )),
              ),
              const SizedBox(height: 15.0,),
              const Divider(thickness: 2,indent: 16,endIndent: 16,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 26),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatus(Colors.green,freshTasks,'live tasks'),
                    _buildStatus(yellow,completedTasks,'Completed'),
                    _buildStatus(purple,createdTasks,'Created'),
                  ],
                ),
              ),
               SizedBox(height: MediaQuery.of(context).size.height * 0.143,),
              UnconstrainedBox(
                child: SizedBox(
                  width: 260,height: 260,
                  child: CircularStepProgressIndicator(
                    totalSteps:createdTasks == 0 ? 1 : createdTasks,
                    currentStep: completedTasks,
                    stepSize: 20,
                    selectedColor: green,
                    unselectedColor: Colors.grey[200],
                    padding: 0,
                    width: 150,height: 150,
                    selectedStepSize: 22,
                    roundedCap: (_,__) => true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${createdTasks == 0 ? 0 : percent} %',style:const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 6,),
                        const Text('Efficiency',style: TextStyle(fontSize: 18,color: Colors.grey,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                ),
              ),
              // weeklyChart(),
            ],
          );
        }),
      )
    );
  }
  _buildStatus(Color color, int number, String title){
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const SizedBox(width: 7.0),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              width:12 ,height: 12,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: 3.0,color: color
                  )
              ),
            ),
            Text('$number',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),

          ],
        ),
        Text(title,style:const TextStyle(color: Colors.black45,fontSize: 16),),

      ],
    );
  }
}
