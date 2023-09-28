import 'package:flutter/material.dart';
import 'package:goflix/pages/bottom_navigaion.dart';
import 'package:goflix/style/colors.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colours.scaffoldBgColor,
        ),
        home: const BottomNavigation());
  }
}
