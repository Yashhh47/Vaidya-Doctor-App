import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanjeevika_doctor_app/view/screens/Details/Patient_details_screen.dart';
import 'package:sanjeevika_doctor_app/view/screens/Loading_screen/loading_screen.dart';
import 'package:sanjeevika_doctor_app/view/screens/home/Home_page.dart';
import 'package:sanjeevika_doctor_app/view/screens/splash/Splash_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: Splash_screen(),
    );
  }
}
