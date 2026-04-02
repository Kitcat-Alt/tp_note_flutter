import 'package:flutter/material.dart';
import '../models/task.dart';
import '../settings/databaseRepository.dart';

class TaskViewModel extends ChangeNotifier {
  final databaseRepository database;
  TaskViewModel({required this.database});

  late List<Task> liste = [];

  void loadTask() async {
    liste = await database.getTasks();
    notifyListeners();
  }

  void addTask(Task task) async {
    await database.insertTask(task);
    loadTask();
  }

  void updateTask(Task task) async {
    await database.updateTask(task);
    loadTask();
  }

  void removeTask(int id) async {
    await database.deleteTask(id);
    loadTask();
  }

  Future<List<Task>> getTasks() async {
    final tasks = await database.getTasks();
    return tasks;
  }

  void generateTasks() async {
    final task_liste = Task.generateTask(50);
    for (Task t in task_liste) {
      await database.insertTask(t);
    }
    loadTask();
  }
}
