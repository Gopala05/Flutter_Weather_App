import 'package:flutter/material.dart';
import 'UI/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Weather App",
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

