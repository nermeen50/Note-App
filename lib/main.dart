import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/helper/bindding.dart';
import 'package:note_app/view/screens/homeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialBinding: BinddingHelper(),
      theme: ThemeData(fontFamily: 'Roboto'),
      home: HomeScreen(),
    );
  }
}
