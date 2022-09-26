// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jiffy/jiffy.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/todo.dart';

import '../provider/todo.dart';

class CompleteScreen extends StatefulWidget {
  const CompleteScreen({super.key, required this.todo});
  final TodoModel todo;

  @override
  State<CompleteScreen> createState() => _CompleteScreenState();
}

class _CompleteScreenState extends State<CompleteScreen> {
  late String description;
  bool isInserting = false;

  @override
  void initState() {
    description = widget.todo.description;
    super.initState();
  }

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
                  builder: (_) => StatefulBuilder(builder: (context, setState) {
                    return ModalProgressHUD(
                      inAsyncCall: isInserting,
                      child: AlertDialog(
                        title: Text('Edit Task'),
                        content: TextFormField(
                          initialValue: description,
                          onChanged: (value) =>
                              setState(() => description = value),
                          minLines: 4,
                          maxLines: 9,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              setState(() => isInserting = !isInserting);
                              await value.update(context,
                                  id: widget.todo.id, description: description);
                              setState(() => isInserting = !isInserting);
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
                  }),
                );
              },
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => StatefulBuilder(builder: (context, setState) {
                    return ModalProgressHUD(
                      inAsyncCall: isInserting,
                      child: AlertDialog(
                        title: Text('delete'),
                        content: Text('Are you sure you wanna delete?'),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              setState(() => isInserting = !isInserting);
                              await value.delete(
                                context,
                                id: widget.todo.id,
                              );
                              setState(() => isInserting = !isInserting);
                            },
                            child: Text('delete'),
                          ),
                        ],
                      ),
                    );
                  }),
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
              Text(widget.todo.description),
              const SizedBox(height: 10),
              Text.rich(
                TextSpan(
                  text: 'Update: ',
                  children: [
                    TextSpan(
                        text: Jiffy(widget.todo.updatedAt)
                            .format('yyyy-MM-dd hh:mm a'),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text.rich(TextSpan(
                text: 'Created:',
                children: [
                  TextSpan(
                      text: Jiffy(widget.todo.createdAt)
                          .format('yyyy-MM-dd hh:mm a'),
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
