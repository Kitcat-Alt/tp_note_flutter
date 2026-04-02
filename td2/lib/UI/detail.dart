import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/task.dart';

class Detail extends StatelessWidget{
  final Task task;

  const Detail({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task ${task.title} detail'),
      ),
      body: Center(
        child: Column(
          children: [
            Card(
              color: Colors.lightBlue,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(Icons.key),
                title: const Text('Identifiant'),
                subtitle: Text('${task.id}'),
              ),
            ),
            Card(
              color: Colors.lightBlue,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(Icons.description),
                title: const Text('description'),
                subtitle: Text(task.description),
              ),
            ),
            Card(
              color: Colors.lightBlue,
              elevation: 7,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: const Icon(Icons.dangerous),
                title: const Text('difficulty'),
                subtitle: Text(task.difficulty.toString()),
              ),
            )
          ],
        ),
      ),
    );
  }


}