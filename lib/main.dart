import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:Imagify/homescreen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Imagify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Tiny',
        colorScheme: const ColorScheme.dark(
          primary: Color.fromRGBO(45, 52, 54, 1),
          secondary: Color.fromRGBO(225, 112, 85, 1),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
