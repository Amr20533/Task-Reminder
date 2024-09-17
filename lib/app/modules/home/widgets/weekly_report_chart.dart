import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_reminder/app/core/values/colors.dart';
import 'package:task_reminder/app/modules/home/controller.dart';

class weeklyChart extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: BarChart(
        BarChartData(
          barGroups: getBarCharts(),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(show: false),
          gridData:FlGridData(show:false),
        ),
      ),
    );
  }

  getBarCharts(){

    var createdTasks = homeCtrl.getTotalTasks();
    var completedTasks = homeCtrl.getTotalDoneTask();
    var freshTasks = createdTasks - completedTasks;
    var totalTasks = homeCtrl.newTodos.length + homeCtrl.doneTodos.length;
    List<dynamic> list =[createdTasks,10.0,15.0,2.0,totalTasks,completedTasks,freshTasks];
    List<double> barChartData = [
      7,
      10,8,7,10,15,9];
    List<BarChartGroupData> barChartGroups=[];
    list.asMap().forEach((i, value)=>barChartGroups.add(
      BarChartGroupData(
        x:i,
        barRods:[
          BarChartRodData(
              toY:value,
              color:i==4?purple:Colors.grey[300],width:16),
        ],
      ),
    ));
    return barChartGroups;
  }
  String getWeek(double value){
    switch(value.toInt()){
      case 0:
        return 'Mon';
      case 1:
        return 'Tue';
      case 3:
        return 'Wen';
      case 4:
        return 'Tur';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }
}