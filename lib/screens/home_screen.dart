import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart'
    show PreferencesManager;
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/achieved_tasks_widget.dart';
import 'package:tasky/widgets/high_priority_tasks_widget.dart';
import '../widgets/sliver_task_list_widget.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  String? motivationQuote;
  List<TaskModel> tasks = [];
  bool isLoading = false;
  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percent = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
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
        tasks = taskAfterDecode
            .map((element) => TaskModel.fromJson(element))
            .toList();
        _calculatePercent();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  void _loadUserData() async {
    setState(() {
      username = PreferencesManager().getString('username');
      motivationQuote =
          PreferencesManager().getString('motivationQuote') ??
          "One task at a time.One step closer.";
    });
  }

  void _calculatePercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((e) => e.isDone).length;
    percent = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
  }

  void _doneTask(bool? value, int? index) async {
    setState(() {
      tasks[index!].isDone = value ?? false;
      _calculatePercent();
    });

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString('tasks', jsonEncode(updatedTask));
  }

  void _deleteTask(int? id) async {
    if (id == null) return;
    setState(() {
      tasks.removeWhere((tasks) => tasks.id == id);
      _calculatePercent();
    });
    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString('tasks', jsonEncode(updatedTask));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/profile.png',
                        ),
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Good Evening ,$username",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            motivationQuote ??
                                "One task at a time.One step closer.",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Yuhuu ,Your work Is",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Row(
                    children: [
                      Text(
                        "almost done ! ",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      CustomSvgPicture.withoutColor(
                        path: 'assets/images/waving_hand.svg',
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  AchievedTasksWidget(
                    totalTasks: totalTasks,
                    totalDoneTasks: totalDoneTasks,
                    percent: percent,
                  ),
                  SizedBox(height: 8),
                  HighPriorityTasksWidget(
                    tasks: tasks,
                    onTap: (bool? value, int? index) {
                      _doneTask(value, index);
                    },
                    refresh: () {
                      _loadTask();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 24, bottom: 16),
                    child: Text(
                      'My Tasks',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
            ),
            isLoading
                ? SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFFFCFC),
                        backgroundColor: Color(0xFF15B86C),
                        strokeWidth: 3,
                      ),
                    ),
                  )
                : SliverTaskListWidget(
                    tasks: tasks,
                    primaryEmptyMessage: "No Tasks Available",
                    secondEmptyMessage: "Tap 'Add New Task' to plan your day.",
                    onTap: (bool? value, int? index) {
                      _doneTask(value, index);
                    },
                    onDelete: (int id) {
                      _deleteTask(id);
                    },
                    onEdit: () => _loadTask(),
                  ),
          ],
        ),
      ),

      floatingActionButton: SizedBox(
        height: 44,
        child: FloatingActionButton.extended(
          onPressed: () async {
            final bool? result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return AddTaskScreen();
                },
              ),
            );
            if (result != null && result) {
              _loadTask();
            }
          },
          icon: Icon(Icons.add),
          label: Text("Add New Task"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
