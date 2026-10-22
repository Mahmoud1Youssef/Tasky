import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/widgets/task_list_widget.dart';
import '../models/task_model.dart';

class CompleteTasksScreen extends StatefulWidget {
  const CompleteTasksScreen({super.key});

  @override
  State<CompleteTasksScreen> createState() => _CompleteTasksScreenState();
}

class _CompleteTasksScreenState extends State<CompleteTasksScreen> {
  List<TaskModel> completeTasks = [];
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

    final finalTAsk = PreferencesManager().getString('tasks');
    if (finalTAsk != null) {
      final taskAfterDecode = jsonDecode(finalTAsk) as List<dynamic>;
      setState(() {
        completeTasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .where((element) => element.isDone)
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
    final finalTAsk = PreferencesManager().getString('tasks');
    if (finalTAsk != null) {
      final taskAfterDecode = jsonDecode(finalTAsk) as List<dynamic>;

      tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();
      tasks.removeWhere((e) => e.id == id);
      setState(() {
        completeTasks.removeWhere((task) => task.id == id);
      });
      final updatedTask = tasks.map((element) => element.toJson()).toList();
      await PreferencesManager().setString('tasks', jsonEncode(updatedTask));
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
            "Completed Tasks",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: TaskListWidget(
              tasks: completeTasks,
              primaryEmptyMessage: "No Completed Tasks Yet",
              secondEmptyMessage: "Tasks you check off will appear here.",
              onTap: (value, index) async {
                setState(() {
                  completeTasks[index!].isDone = value ?? false;
                });

                final allaData = PreferencesManager().getString('tasks');
                if (allaData != null) {
                  List<TaskModel> allDataList = (jsonDecode(allaData) as List)
                      .map((element) => TaskModel.fromJson(element))
                      .toList();
                  final newIndex = allDataList.indexWhere(
                    (e) => e.id == completeTasks[index!].id,
                  );
                  allDataList[newIndex] = completeTasks[index!];
                  await PreferencesManager().setString(
                    'tasks',
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
