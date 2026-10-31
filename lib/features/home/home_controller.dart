import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import '../../core/constants/storage_key.dart';
import '../../core/services/preferences_manager.dart';

class HomeController with ChangeNotifier {
  List<TaskModel> tasksList = [];
  String? username;
  String? motivationQuote;
  String? userImagePath;
  List<TaskModel> tasks = [];
  bool isLoading = false;
  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percent = 0;

  void init() {
    loadUserData();
    loadTask();
  }

  void loadTask() async {
    isLoading = true;

    final finalTAsk = PreferencesManager().getString(StorageKey.tasks);
    if (finalTAsk != null) {
      final taskAfterDecode = jsonDecode(finalTAsk) as List<dynamic>;

      tasks = taskAfterDecode
          .map((element) => TaskModel.fromJson(element))
          .toList();
      calculatePercent();
    }

    isLoading = false;
    notifyListeners();
  }

  void loadUserData() async {
    username = PreferencesManager().getString(StorageKey.username);
    motivationQuote =
        PreferencesManager().getString(StorageKey.motivationQuote) ??
        "One task at a time.One step closer.";
    userImagePath = PreferencesManager().getString(StorageKey.userImage);
    notifyListeners();
  }

  void calculatePercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((e) => e.isDone).length;
    percent = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
    notifyListeners();
  }

  void doneTask(bool? value, int? index) async {
    tasks[index!].isDone = value ?? false;
    calculatePercent();

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
    notifyListeners();
  }

  void deleteTask(int? id) async {
    if (id == null) return;
    tasks.removeWhere((tasks) => tasks.id == id);
    calculatePercent();

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
    notifyListeners();
  }
}
