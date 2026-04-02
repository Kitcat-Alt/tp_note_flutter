import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td2/models/task.dart';
import 'package:td2/UI/add_task.dart';

import '../viewModel/TaskViewModel.dart';
import 'detail.dart';

class home extends StatelessWidget {
  home({super.key});

  late List<Task> tasks;
  String tags = '';

  @override
  Widget build(BuildContext context) {
    tasks = context.watch<TaskViewModel>().liste;
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          final task = tasks[index];
          return Card(
            color: Colors.white,
            elevation: 7,
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.lightBlue,
                child: Text(task.id.toString()),
              ),
              title: Text(task.title),
              subtitle: Text(task.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddTask(task: task),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<TaskViewModel>().removeTask(task.id);
                    },
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => Detail(task: task),
                  ),
                );
              },
            ),
          );
        });
  }
}
