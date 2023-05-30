import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/domain/services/local_storage.dart';

class LocalStorageImpl implements LocalStorage {
  static const String boxname = 'tasks';
  static Box<Task>? tasks;

  @override
  Future<void> addTask(Task task) async {
    await tasks?.put(task.id, task);
  }

  @override
  Future<void> clearData() async {
    await tasks?.clear();
  }

  @override
  Future<void> editTask(String id, Task editedTask) async {
    if (tasks?.containsKey(id) ?? false) {
      await tasks?.put(id, editedTask);
    } else {
      throw Exception("Key not found.");
    }
  }

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskAdapter());
    if (tasks == null && !Hive.isBoxOpen(boxname)) {
      tasks = await Hive.openBox<Task>(boxname);
    }
  }

  @override
  List<Task> getAllTask() {
    List<Task> allTasks = [];
    for (String key in tasks?.keys.toList() ?? []) {
      allTasks.add(tasks!.get(key)!);
    }

    return allTasks;
  }

  @override
  Future<void> removeTask(String id) async {
    if (tasks?.containsKey(id) ?? false) {
      await tasks?.delete(id);
    }
  }

  @override
  Future<void> dispose() async {
    await tasks?.close();
  }

  @override
  Task getTask(String id) {
    return tasks!.get(id)!;
  }
}
