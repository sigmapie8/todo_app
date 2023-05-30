import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_app/application/tasks/task_state_widget.dart';
import 'package:todo_app/domain/services/local_storage.dart';
import 'package:todo_app/presentation/add_or_edit_task.dart';
import 'package:todo_app/presentation/task_home.dart';
import 'package:todo_app/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // setup service locator
  setup();

  // initializing Hive database
  await GetIt.instance<LocalStorage>().init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const TaskStateWidget(
      child: MaterialApp(
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const TaskHome(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (c) => const AddOrEditTask())),
      ),
    );
  }
}
