import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/provider/user.dart';
import 'package:todolist/screen/home.dart';

import '../models/login.dart';
import 'package:http/http.dart' as http;

class TodoProvider with ChangeNotifier {
  var todos = <TodoModel>[];
  bool isloading = false;

  Future update(
    BuildContext context, {
    required String id,
    required String description,
  }) async {
    String token =
        Provider.of<UserProvider>(context, listen: false).currentUser.token;

    try {
      isloading = true;
      notifyListeners();
      var response = await http.put(
        Uri.parse('https://api-nodejs-todolist.herokuapp.com/task/$id'),
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

        for (var todo in todos) {
          if (todo.id == id) {
            todo.description = description;
            todo.updatedAt = DateTime.now();
            notifyListeners();
          }
        }
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response.body),
        ));
      }
    } catch (e) {
      print(e);
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  Future delete(
    BuildContext context, {
    required String id,
  }) async {
    String token =
        Provider.of<UserProvider>(context, listen: false).currentUser.token;
    print(token);

    try {
      isloading = true;
      notifyListeners();
      var response = await http.delete(
        Uri.parse('https://api-nodejs-todolist.herokuapp.com/task/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final data = jsonDecode(response.body);
        todos.removeWhere((e) => e.id == id);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));

        notifyListeners();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response.body),
        ));
      }
    } catch (e) {
      print(e);
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  Future add(
    BuildContext context, {
    required String description,
  }) async {
    try {
      isloading = true;
      notifyListeners();
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
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  Future getTodos(BuildContext context) async {
    try {
      isloading = true;
      notifyListeners();
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
        notifyListeners();

        // Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response.body),
        ));
      }
    } catch (e) {
      print(e);
    } finally {
      isloading = false;
      notifyListeners();
    }
  }
}
