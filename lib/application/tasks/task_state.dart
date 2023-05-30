import 'package:equatable/equatable.dart';
import 'package:todo_app/domain/entities/task.dart';

class TaskState extends Equatable {
  final List<Task> tasks;

  const TaskState(this.tasks);

  @override
  List<Object?> get props => tasks;
}
