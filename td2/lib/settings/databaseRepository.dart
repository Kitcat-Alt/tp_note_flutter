import 'package:sqflite/sqflite.dart';
import 'package:td2/models/task.dart';

class databaseRepository{
  final Database db;
  databaseRepository({required this.db});

  Future<void> insertTask(Task task) async{
    await this.db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTask(Task task) async {
    await this.db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int id) async {
    await this.db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Task>> getTasks() async {
    final List<Map<String, Object?>> tasksMaps = await this.db.query('tasks');

    // Convert the list of each dog's fields into a list of `Dog` objects.
    return tasksMaps.map((map) {
      Task t = Task.fromMap(map);
      return t;
    }).toList();
  }}