import 'package:flutter/material.dart';
import 'package:masseyhacks/doctor_home.dart';
import 'package:masseyhacks/login.dart';

import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      theme: ThemeData(primaryColor: Color(4278656558)),
    );
  }
}
