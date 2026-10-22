import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';

import '../models/task_model.dart';
import '../widgets/task_list_widget.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
  List<TaskModel> highPriorityTasks = [];
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
        highPriorityTasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .where((element) => element.isHighPriority)
            .toList();
        highPriorityTasks = highPriorityTasks.reversed.toList();
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
        highPriorityTasks.removeWhere((task) => task.id == id);
      });
      final updatedTask = tasks.map((element) => element.toJson()).toList();
      await PreferencesManager().setString('tasks', jsonEncode(updatedTask));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("High Priority Tasks")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: TaskListWidget(
          tasks: highPriorityTasks,
          primaryEmptyMessage: "No Pending Tasks",
          secondEmptyMessage:
              "You're all set! Add new tasks whenever you're ready.",
          onTap: (value, index) async {
            setState(() {
              highPriorityTasks[index!].isDone = value ?? false;
            });

            final allaData = PreferencesManager().getString('tasks');
            if (allaData != null) {
              List<TaskModel> allDataList = (jsonDecode(allaData) as List)
                  .map((element) => TaskModel.fromJson(element))
                  .toList();
              final newIndex = allDataList.indexWhere(
                (e) => e.id == highPriorityTasks[index!].id,
              );
              allDataList[newIndex] = highPriorityTasks[index!];
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
    );
  }
}
