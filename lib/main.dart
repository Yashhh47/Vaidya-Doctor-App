import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanjeevika_doctor_app/view/screens/Details/Patient_details_screen.dart';
import 'package:sanjeevika_doctor_app/view/screens/Loading_screen/loading_screen.dart';
import 'package:sanjeevika_doctor_app/view/screens/home/Home_page.dart';
import 'package:sanjeevika_doctor_app/view/screens/splash/Splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: PatientDetailsScreen(),
    );
  }
}
