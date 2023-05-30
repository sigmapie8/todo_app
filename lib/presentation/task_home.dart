import 'package:flutter/material.dart';
import 'package:todo_app/application/tasks/task_state_scope.dart';
import 'package:todo_app/application/tasks/task_state_widget.dart';
import 'package:todo_app/domain/policies/search_policy.dart';
import 'package:todo_app/presentation/add_or_edit_task.dart';
import 'package:todo_app/presentation/task_widget.dart';

class TaskHome extends StatefulWidget {
  const TaskHome({Key? key}) : super(key: key);

  @override
  State<TaskHome> createState() => _TaskHomeState();
}

class _TaskHomeState extends State<TaskHome> {
  bool _isSearchOn = false;
  bool _gridView = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void toggleSearch() {
    if (_isSearchOn) {
      setState(() {
        _isSearchOn = false;
        _searchController.clear();
        TaskStateWidget.of(context).resetSearch();
      });
    } else {
      setState(() {
        _isSearchOn = true;
        _searchFocusNode.requestFocus();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final allTasks = TaskStateScope.of(context).tasks;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: _isSearchOn
              ? SizedBox(
                  height: 40.0,
                  child: TextField(
                    style: const TextStyle(fontSize: 15.0),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: Colors.blue,
                      hintText: "Search",
                      hintMaxLines: 1,
                      hintStyle: TextStyle(color: Colors.blue),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.0))),
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                    ),
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    maxLines: 1,
                    onChanged: (value) {
                      if (SearchPolicy.searchTextPolicy(value) == 0) {
                        TaskStateWidget.of(context).search(value);
                      }
                    },
                  ),
                )
              : const Text("Tasks"),
          centerTitle: true,
          actions: [
            _isSearchOn
                ? IconButton(
                    onPressed: () => toggleSearch(),
                    icon: const Icon(Icons.highlight_off))
                : IconButton(
                    onPressed: () => toggleSearch(),
                    icon: const Icon(Icons.search)),
            _gridView
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _gridView = !_gridView;
                      });
                    },
                    icon: const Icon(
                      Icons.grid_view,
                    ))
                : IconButton(
                    onPressed: () {
                      setState(() {
                        _gridView = !_gridView;
                      });
                    },
                    icon: const Icon(
                      Icons.list,
                    ))
          ],
          pinned: true,
        ),
        _gridView
            ? SliverGrid.builder(
                itemCount: allTasks.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return TaskWidget(
                      task: allTasks[index],
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => AddOrEditTask(
                                      task: allTasks[index],
                                    )),
                          ));
                })
            : SliverToBoxAdapter(
                child: Column(
                  children: List.generate(
                      allTasks.length,
                      (index) => TaskWidget(
                          task: allTasks[index],
                          onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => AddOrEditTask(
                                          task: allTasks[index],
                                        )),
                              ))),
                ),
              ),
      ],
    );
  }
}
