// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CompleteScreen extends StatelessWidget {
  const CompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            const Text(
                'Lorem ipsum dolor, sit amet consectetur adipisicing elit.Deleniti itaque placeat tempora, nobis harum nemo deserunt cum voluptate id? Rerum! '),
            const SizedBox(height: 10),
            const Text.rich(
              TextSpan(
                text: 'Update: ',
                children: [
                  TextSpan(
                      text: '20/09/2022',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text.rich(TextSpan(
              text: 'Created:',
              children: [
                TextSpan(
                    text: '10/09/2022',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
