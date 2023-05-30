import 'package:todo_app/domain/entities/task.dart';

abstract class LocalStorage {
  Future<void> init();
  List<Task> getAllTask();
  Task getTask(String id);
  Future<void> clearData();
  Future<void> addTask(Task task);
  Future<void> removeTask(String id);
  Future<void> editTask(String id, Task editedTask);
  Future<void> dispose();
}
