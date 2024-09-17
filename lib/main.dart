import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_reminder/app/data/services/services_storage/services.dart';
import 'package:task_reminder/app/modules/home/binding.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:task_reminder/app/modules/home/view.dart';
void main() async{
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(splash: Center(child: Image.asset('assets/images/logo_generated.png'),),nextScreen: const HomeScreen(),
      backgroundColor:Colors.white.withOpacity(0.3),
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 220,),
      initialBinding: HomeBinding(),
      builder:EasyLoading.init(),
    );
  }
}