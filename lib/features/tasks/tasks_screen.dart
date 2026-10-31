import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/components/task_list_widget.dart';
import '../../models/task_model.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<TaskModel> todoTasks = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadTask();
  }

  void _loadTask() async {
    setState(() {
      isLoading = true;
    });

    final finalTAsk = PreferencesManager().getString(StorageKey.tasks);
    if (finalTAsk != null) {
      final taskAfterDecode = jsonDecode(finalTAsk) as List<dynamic>;
      setState(() {
        todoTasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .where((element) => element.isDone == false)
            .toList();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  void _deleteTask(int? id) async {
    List<TaskModel> tasks = [];

    if (id == null) return;
    final finalTAsk = PreferencesManager().getString(StorageKey.tasks);
    if (finalTAsk != null) {
      final taskAfterDecode = jsonDecode(finalTAsk) as List<dynamic>;

      tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();
      tasks.removeWhere((e) => e.id == id);
      setState(() {
        todoTasks.removeWhere((task) => task.id == id);
      });
      final updatedTask = tasks.map((element) => element.toJson()).toList();
      await PreferencesManager().setString(
        StorageKey.tasks,
        jsonEncode(updatedTask),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(18),
          child: Text(
            "To Do Tasks",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: TaskListWidget(
              tasks: todoTasks,
              primaryEmptyMessage: "No Pending Tasks",
              secondEmptyMessage:
                  "You're all set! Add new tasks whenever you're ready.",
              onTap: (value, index) async {
                setState(() {
                  todoTasks[index!].isDone = value ?? false;
                });

                final allaData = PreferencesManager().getString(
                  StorageKey.tasks,
                );
                if (allaData != null) {
                  List<TaskModel> allDataList = (jsonDecode(allaData) as List)
                      .map((element) => TaskModel.fromJson(element))
                      .toList();
                  final newIndex = allDataList.indexWhere(
                    (e) => e.id == todoTasks[index!].id,
                  );
                  allDataList[newIndex] = todoTasks[index!];
                  await PreferencesManager().setString(
                    StorageKey.tasks,
                    jsonEncode(allDataList),
                  );
                  _loadTask();
                }
              },
              onDelete: (int id) {
                _deleteTask(id);
              },
              onEdit: () => _loadTask(),
            ),
          ),
        ),
      ],
    );
  }
}
