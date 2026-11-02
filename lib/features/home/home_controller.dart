import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import '../../core/constants/storage_key.dart';
import '../../core/services/preferences_manager.dart';

class HomeController with ChangeNotifier {
  List<TaskModel> tasksList = [];
  String? username;
  String? motivationQuote;
  String? userImagePath;
  bool isLoading = false;

  void init() {
    loadUserData();
  }

  void loadUserData() async {
    username = PreferencesManager().getString(StorageKey.username);
    motivationQuote =
        PreferencesManager().getString(StorageKey.motivationQuote) ??
        "One task at a time.One step closer.";
    userImagePath = PreferencesManager().getString(StorageKey.userImage);
    notifyListeners();
  }
}
