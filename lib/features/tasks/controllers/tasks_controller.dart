import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../core/constants/storage_key.dart';
import '../../../core/services/preferences_manager.dart';
import '../../../models/task_model.dart';

class TasksController with ChangeNotifier {
  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percent = 0;
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
      _loadData();
      calculatePercent();
    }
    isLoading = false;
    notifyListeners();
  }

  void _loadData() {
    todoTasks = tasks.where((element) => element.isDone == false).toList();
    completeTasks = tasks.where((element) => element.isDone).toList();
    highPriorityTasks = tasks
        .where((element) => element.isHighPriority)
        .toList();
    highPriorityTasks = highPriorityTasks.reversed.toList();
  }

  void doneTask(bool? value, int? id) async {
    if (id == null) return;
    final index = tasks.indexWhere((e) => e.id == id);
    if (index == -1) return;

    tasks[index].isDone = value ?? false;
    _loadData();
    calculatePercent();

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    await PreferencesManager().setString(
      StorageKey.tasks,
      jsonEncode(updatedTask),
    );
    notifyListeners();
  }

  void deleteTask(int? id) async {
    if (id == null) return;

    tasks.removeWhere((e) => e.id == id);
    _loadData();
    calculatePercent();

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    await PreferencesManager().setString(
      StorageKey.tasks,
      jsonEncode(updatedTask),
    );
    notifyListeners();
  }

  void calculatePercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((e) => e.isDone).length;
    percent = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
  }
}
