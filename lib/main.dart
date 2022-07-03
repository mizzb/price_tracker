import 'package:flutter/material.dart';
import 'package:price_tracker/views/home_screen.dart';
import 'injector.dart';

void main() async {
  // initialize depended services
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Price Tracker',
      home: HomeScreen(),
    );
  }
}
