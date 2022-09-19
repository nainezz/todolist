import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todolist/models/login.dart';
import 'package:http/http.dart' as http;

import '../screen/home.dart';

class UserProvider with ChangeNotifier {
  late UserModel currentUser;

  void updateUser(UserModel user) {
    currentUser = user;
    notifyListeners();
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
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
