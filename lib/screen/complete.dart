// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/todo.dart';

import '../provider/todo.dart';

class CompleteScreen extends StatelessWidget {
  const CompleteScreen({super.key, required this.todo});
  final TodoModel todo;

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(builder: (context, value, _) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('show'),
                    content: TextFormField(
                      initialValue:
                          'Lorem ipsum dolor, sit amet consectetur adipisicing elit.Deleniti itaque placeat tempora, nobis harum nemo deserunt cum voluptate id? Rerum! ',
                      minLines: 4,
                      maxLines: 9,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('update'),
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
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('delete'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('delete'),
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(Icons.delete),
            ),
          ],
          elevation: 0,
          title: const Text('Completed'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(todo.description),
              const SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: 'Update: ',
                  children: [
                    TextSpan(
                        text:
                            Jiffy(todo.updatedAt).format('yyyy-MM-dd hh:mm a'),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text.rich(TextSpan(
                text: 'Created:',
                children: [
                  TextSpan(
                      text: Jiffy(todo.createdAt).format('yyyy-MM-dd hh:mm a'),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              )),
            ],
          ),
        ),
      );
    });
  }
}
