import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../core/constants/storage_key.dart';
import '../../../core/services/preferences_manager.dart';
import '../../../models/task_model.dart';

class TasksController with ChangeNotifier {
  bool isLoading = false;

  List<TaskModel> tasks = [];
  List<TaskModel> completeTasks = [];
  List<TaskModel> highPriorityTasks = [];
  List<TaskModel> todoTasks = [];

  void init() {
    _loadTasks();
  }

  void _loadTasks() {
    isLoading = true;

    final finalTAsk = PreferencesManager().getString(StorageKey.tasks);
    if (finalTAsk != null) {
      final taskAfterDecode = jsonDecode(finalTAsk) as List<dynamic>;

      tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();
      todoTasks = tasks.where((element) => element.isDone == false).toList();
      completeTasks = tasks.where((element) => element.isDone).toList();
      highPriorityTasks = tasks
        .where((element) => element.isHighPriority).toList();
      highPriorityTasks = highPriorityTasks.reversed.toList();
    }

    isLoading = false;
    notifyListeners();
  }

  void doneTask(bool? value, int? index, List? task) async {
    if (index == null) return;
    task?[index].isDone = value ?? false;

    final int newIndex = tasks.indexWhere((e) => e.id == task?[index].id);
    tasks[newIndex] = task?[index];
    await PreferencesManager().setString(StorageKey.tasks, jsonEncode(tasks));
    _loadTasks();
    notifyListeners();
  }

  void deleteTask(int? id, List? task) async {
    if (id == null) return;

    tasks.removeWhere((e) => e.id == id);

    task?.removeWhere((task) => task.id == id);

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    await PreferencesManager().setString(
      StorageKey.tasks,
      jsonEncode(updatedTask),
    );
    notifyListeners();
  }
}
