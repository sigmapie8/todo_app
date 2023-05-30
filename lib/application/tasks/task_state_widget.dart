import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_app/application/tasks/task_state.dart';
import 'package:todo_app/application/tasks/task_state_scope.dart';
import 'package:todo_app/application/utility/utilities.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/domain/services/local_storage.dart';

class TaskStateWidget extends StatefulWidget {
  const TaskStateWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  static TaskStateWidgetState of(BuildContext context) {
    return context.findAncestorStateOfType<TaskStateWidgetState>()!;
  }

  @override
  State<TaskStateWidget> createState() => TaskStateWidgetState();
}

class TaskStateWidgetState extends State<TaskStateWidget> {
  TaskState taskState = const TaskState([]);
  bool _search = false;

  Future<void> addTask(
      {required String title, required String description}) async {
    // task creation
    final currentDateTime = DateTime.now();
    final Task newTask = Task(
        id: Utilities.getIdForTask(),
        title: title,
        description: description,
        updatedDateTime: currentDateTime,
        createdDateTime: currentDateTime);

    // adding it to the localdb
    final localStorage = GetIt.instance<LocalStorage>();
    await localStorage.addTask(newTask);

    // adding task in taskstate
    setState(() {});
  }

  Future<void> deleteTask({required String id}) async {
    // removing from local db
    final localStorage = GetIt.instance<LocalStorage>();
    await localStorage.removeTask(id);

    setState(() {});
  }

  Future<void> editTask(
      {required String id,
      required String title,
      required String description}) async {
    final localStorage = GetIt.instance<LocalStorage>();

    // getting old task
    final oldTask = localStorage.getTask(id);

    // creating new task to replace the old
    final newTask = Task(
        id: oldTask.id,
        title: title,
        description: description,
        updatedDateTime: DateTime.now(),
        createdDateTime: oldTask.createdDateTime);

    // replacing
    localStorage.editTask(id, newTask);

    setState(() {});
  }

  void search(String search) {
    final localStorage = GetIt.instance<LocalStorage>();
    List<Task> allTaskFromLocal = localStorage.getAllTask();

    List<Task> searchResult = [];
    for (Task task in allTaskFromLocal) {
      if (task.title.toLowerCase().contains(search.toLowerCase()) ||
          task.description.toLowerCase().contains(search.toLowerCase())) {
        searchResult.add(task);
      }
    }

    searchResult
        .sort(((a, b) => b.updatedDateTime.compareTo(a.updatedDateTime)));

    setState(() {
      taskState = TaskState(searchResult);
      _search = true;
    });
  }

  void resetSearch() {
    setState(() {
      _search = !_search;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_search) {
      return TaskStateScope(taskState, child: widget.child);
    }

    // load tasks from localdb
    final localStorage = GetIt.instance<LocalStorage>();
    List<Task> allTaskFromLocal = localStorage.getAllTask();

    // sorted by [updatedDateTime] in descending order
    allTaskFromLocal
        .sort(((a, b) => b.updatedDateTime.compareTo(a.updatedDateTime)));

    taskState = TaskState(allTaskFromLocal);

    return TaskStateScope(taskState, child: widget.child);
  }
}
