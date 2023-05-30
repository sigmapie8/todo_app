import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/application/tasks/task_state_widget.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/domain/policies/task_policy.dart';
import 'package:timeago/timeago.dart' as timeago;

class AddOrEditTask extends StatefulWidget {
  const AddOrEditTask({Key? key, this.task}) : super(key: key);

  final Task? task;

  @override
  State<AddOrEditTask> createState() => _AddOrEditTaskState();
}

class _AddOrEditTaskState extends State<AddOrEditTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _bodyFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _bodyController.text = widget.task!.description;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _titleFocusNode.dispose();
    _bodyFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.task == null
            ? const Text("New Task")
            : Text(widget.task!.title),
        actions: [
          IconButton(
              onPressed: () {
                if (TaskPolicy.titlePolicy(_titleController.text) == 0) {
                  if (widget.task != null) {
                    TaskStateWidget.of(context).editTask(
                        id: widget.task!.id,
                        title: _titleController.text,
                        description: _bodyController.text);
                  } else {
                    TaskStateWidget.of(context).addTask(
                        title: _titleController.text,
                        description: _bodyController.text);
                  }
                  Navigator.pop(context);
                }
              },
              icon: const Icon(
                Icons.save_outlined,
              ))
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            child: TextField(
              controller: _titleController,
              focusNode: _titleFocusNode,
              cursorColor: Colors.black12,
              cursorHeight: 25.0,
              style: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              maxLengthEnforcement:
                  MaxLengthEnforcement.truncateAfterCompositionEnds,
              decoration: const InputDecoration.collapsed(
                hintText: "Title",
                hintStyle: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: Colors.grey,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: TextField(
              controller: _bodyController,
              focusNode: _bodyFocusNode,
              cursorHeight: 20.0,
              cursorColor: Colors.black12,
              decoration: const InputDecoration.collapsed(
                  hintText: "Task",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.0,
                  )),
              maxLines: null,
              style: const TextStyle(
                fontSize: 15.0,
              ),
            ),
          )),
          // If we're editing the task, we should show the last edited time
          // else nothing
          widget.task != null
              ? Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                      "Updated ${timeago.format(widget.task?.updatedDateTime ?? DateTime.now())}"),
                )
              : const SizedBox(
                  height: 50.0,
                ),
        ],
      ),
    );
  }
}
