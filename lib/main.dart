import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_web_app/screens/dashboard_screen/dashboard_screen.dart';
import 'package:news_web_app/screens/login_screen/login_screen.dart';
import 'package:news_web_app/utils/color_res.dart';
import 'Services/Shared_pref_services/pref_service.dart';

Future<void> main() async {
  await PrefService.init();
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        authDomain: "news-app-c50bf.firebaseapp.com",
        apiKey: "AIzaSyAZXMNJlaiaJq2hjc_bD8jz2j9FL8XzNaE",
        appId: "1:412875739905:web:e0d2e01f4fd678e5104100",
        messagingSenderId: "412875739905",
        projectId: "news-app-c50bf",
        storageBucket: "news-app-c50bf.appspot.com",
      ),
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News Admin Panel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ColorRes.appColor),
        useMaterial3: true,
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: ColorRes.datePicker,
        ),
        timePickerTheme: const TimePickerThemeData(
          backgroundColor: ColorRes.datePicker,
        ),
      ),
      home: PrefService.getBool('isLogged')
          ? const DashBoardScreen()
          : const LoginScreen(),
    );
  }
}
