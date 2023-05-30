import 'package:flutter/material.dart';
import 'package:todo_app/application/tasks/task_state_widget.dart';
import 'package:todo_app/domain/entities/task.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({Key? key, required this.task, required this.onTap})
      : super(key: key);

  final Task task;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      color: Colors.white70,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 150.0, maxHeight: 200.0),
        child: GestureDetector(
          onTap: () => onTap(),
          behavior: HitTestBehavior.opaque,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 7,
                      child: Text(
                        task.title,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {
                            TaskStateWidget.of(context).deleteTask(id: task.id);
                          },
                          icon: const Icon(Icons.highlight_off)),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Text(
                      task.description,
                      style: const TextStyle(
                        fontSize: 15.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 7,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
