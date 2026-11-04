import 'package:flutter/material.dart';

import 'screens/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Custom Navigation App',
      theme: ThemeData(useMaterial3: true, fontFamily: 'Roboto'),
      home: const MyHomePage(),
    );
  }
}
