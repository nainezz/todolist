import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todolist/models/login.dart';
import 'package:http/http.dart' as http;
import 'package:todolist/screen/login.dart';
import 'package:todolist/screen/registration.dart';

import '../screen/home.dart';

class UserProvider with ChangeNotifier {
  final box = GetStorage();
  late UserModel currentUser;

  // Constructor
  UserProvider() {
    if (box.read('user') != null) {
      currentUser = UserModel.fromJson(box.read('user'));
    }
  }

  void logout(BuildContext context) async {
    await box.remove('user');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false);
  }

  void updateUser(UserModel user) {
    currentUser = user;
    // notifyListeners();
  }

  Future login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    try {
      var response = await http.post(
        Uri.parse('https://api-nodejs-todolist.herokuapp.com/user/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          {
            "email": email,
            "password": password,
          },
        ),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        currentUser = UserModel.fromJson(data);
        final box = GetStorage();
        box.write('user', data);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response.body),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  Future register(
    BuildContext context, {
    required String email,
    required String password,
    required String name,
    required int age,
  }) async {
    try {
      var response = await http.post(
        Uri.parse('https://api-nodejs-todolist.herokuapp.com/user/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          {"name": name, "email": email, "password": password, "age": age},
        ),
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final data = jsonDecode(response.body);
        print(data);
        currentUser = UserModel.fromJson(data);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response.body),
        ));
      }
    } catch (e) {
      print(e);
    }
  }
}
