import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/provider/user.dart';

import '../models/login.dart';
import 'package:http/http.dart' as http;

class TodoProvider with ChangeNotifier {
  var todos = <TodoModel>[];
  Future update(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    String token =
        Provider.of<UserProvider>(context, listen: false).currentUser.token;
    print(token);

    try {
      var response = await http.post(
        Uri.parse(
            'https://api-nodejs-todolist.herokuapp.com/task/5ddcd1566b55da0017597239'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(
          {"Completed": true},
        ),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response.body),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  Future add(
    BuildContext context, {
    required String description,
  }) async {
    try {
      String token =
          Provider.of<UserProvider>(context, listen: false).currentUser.token;
      var response = await http.post(
        Uri.parse('https://api-nodejs-todolist.herokuapp.com/task'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(
          {"description": description},
        ),
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final data = jsonDecode(response.body);
        todos.add(TodoModel.fromJson(data['data']));
        notifyListeners();

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response.body),
        ));
      }
    } catch (e) {
      print(e);
    }
  }

  Future getTodos(BuildContext context) async {
    try {
      String token =
          Provider.of<UserProvider>(context, listen: false).currentUser.token;
      var response = await http.get(
        Uri.parse('https://api-nodejs-todolist.herokuapp.com/task'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final decodedData = jsonDecode(response.body);
        final List data = decodedData['data'];
        todos.clear();
        for (var todo in data) {
          todos.add(TodoModel.fromJson(todo));
        }
        print(data);
        notifyListeners();

        // Navigator.pop(context);
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
