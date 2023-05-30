import 'package:flutter/widgets.dart';
import 'package:todo_app/application/tasks/task_state.dart';

class TaskStateScope extends InheritedWidget {
  const TaskStateScope(this.taskState, {super.key, required super.child});

  final TaskState taskState;

  static TaskState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TaskStateScope>()!
        .taskState;
  }

  @override
  bool updateShouldNotify(TaskStateScope oldWidget) {
    return taskState != oldWidget.taskState;
  }
}
