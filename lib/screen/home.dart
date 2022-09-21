// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:todolist/provider/todo.dart';
import 'package:todolist/provider/user.dart';

import 'complete.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  String description = '';

  @override
  Widget build(BuildContext context) {
    Provider.of<TodoProvider>(context, listen: false).getTodos(context);
    return Consumer2<UserProvider, TodoProvider>(
        builder: (context, userProvider, todoProvider, _) {
      return Scaffold(
        // backgroundColor: Color(0x181920),
        appBar: AppBar(
          title: Text('TO DO LIST'),
          // backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.srcATop),
                  fit: BoxFit.cover,
                  image: const NetworkImage(
                      'https://www.thespruce.com/thmb/ritGMS02HXyUlRpsQWQtvrMIjc8=/4000x3000/smart/filters:no_upscale()/organizing-a-to-do-list-2648011-hero-16c4949473354d57aab32e06a7cd619e.jpg'),
                )),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white70,
                        child: FlutterLogo(),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        userProvider.currentUser.name,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        userProvider.currentUser.email,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              const ListTile(
                leading: Icon(
                  Icons.home,
                ),
                title: Text('HOME'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.home,
                ),
                title: Text('HOME'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.home,
                ),
                title: Text('HOME'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.home,
                ),
                title: Text('HOME'),
              ),
              const ListTile(
                leading: Icon(
                  Icons.home,
                ),
                title: Text('HOME'),
              ),
            ],
          ),
        ),
        body: ListView.builder(
          itemCount: todoProvider.todos.length,
          itemBuilder: (BuildContext context, index) {
            return ListTile(
              title: Text(todoProvider.todos[index].description),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CompleteScreen(todo: todoProvider.todos[index])));
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text('New Task'),
                content: TextFormField(
                  onChanged: (value) => description = value,
                  minLines: 4,
                  maxLines: 9,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      todoProvider.add(context, description: description);
                    },
                    child: Text('Add'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('cancel'),
                  ),
                ],
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      );
    });
  }
}
