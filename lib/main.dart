import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/firstPage.dart';
import 'package:flutter_application_1/Pages/settingsPage.dart';

import 'Pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/homePage': (context) => HomePage(),
        '/firstPage': (context) => Firstpage(),
        '/settingPage': (context) => Settingspage()
        
      },
    );
  }
}

