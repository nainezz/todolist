// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:todolist/provider/todo.dart';
import 'package:todolist/provider/user.dart';

import 'complete.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AfterLayoutMixin<HomeScreen> {
  String description = '';
  bool _ischecked = false;
  bool isInserting = false;

  @override
  Widget build(BuildContext context) {
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
              ListTile(
                leading: Icon(
                  Icons.logout_outlined,
                  color: Colors.red,
                ),
                title: Text('Logout'),
                onTap: () {
                  userProvider.logout(context);
                },
              ),
            ],
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: todoProvider.isloading,
          child: ListView.builder(
            itemCount: todoProvider.todos.length,
            itemBuilder: (BuildContext context, index) {
              return ListTile(
                leading: Checkbox(
                  value: todoProvider.todos[index].completed,
                  onChanged: (bool? value) {
                    setState(() {
                      // _ischecked = value!;
                      todoProvider.todos[index].completed = value!;
                    });
                  },
                ),
                title: Text(
                  todoProvider.todos[index].description,
                  style: TextStyle(
                      decoration: todoProvider.todos[index].completed
                          ? TextDecoration.lineThrough
                          : null),
                ),
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => StatefulBuilder(builder: (context, setState) {
                return ModalProgressHUD(
                  inAsyncCall: isInserting,
                  child: AlertDialog(
                    title: Text('New Task'),
                    content: TextFormField(onChanged: (value) {
                      description = value;
                      minLines:
                      4;
                      maxLines:
                      9;
                    }),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          setState(() => isInserting = !isInserting);
                          await todoProvider.add(context,
                              description: description);
                          setState(() => isInserting = !isInserting);
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
              }),
            );
          },
          child: Icon(Icons.add),
        ),
      );
    });
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    Provider.of<TodoProvider>(context, listen: false).getTodos(context);
  }
}
