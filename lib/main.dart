import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/provider/user.dart';
import 'package:todolist/screen/home.dart';
import 'package:todolist/screen/login.dart';
import 'package:todolist/screen/registration.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
