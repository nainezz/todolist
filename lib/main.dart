import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/login.dart';
import 'package:todolist/provider/todo.dart';
import 'package:todolist/provider/user.dart';
import 'package:todolist/screen/home.dart';
import 'package:todolist/screen/login.dart';
import 'package:todolist/screen/registration.dart';

void main() async {
  await GetStorage.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider()),
        ChangeNotifierProvider.value(value: TodoProvider()),
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
  final box = GetStorage();

  UserModel? get user {
    if (box.read('user') == null) return null;
    return UserModel.fromJson(box.read('user'));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: user != null ? HomeScreen() : const LoginScreen(),
    );
  }
}
