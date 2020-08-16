import 'package:flutter/material.dart';
import 'package:Weapon_Detect/mainpage.dart';
//2020/02/17 Code change by
//Code change by ananyamous
// ignore: must_be_immutable
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID - Visualizer',
      home: new MainPage(title: 'Covid Visualizer')
    );

  }

}