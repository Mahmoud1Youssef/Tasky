import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/features/home/home_controller.dart';
import 'package:tasky/features/home/components/achieved_tasks_widget.dart';
import 'package:tasky/features/home/components/high_priority_tasks_widget.dart';
import 'components/sliver_task_list_widget.dart';
import '../add_task/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController()..init(),
      child: Consumer<HomeController>(
        builder: (BuildContext context, HomeController value, Widget? child) {
          final HomeController controller = context.read<HomeController>();

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
                              backgroundImage: value.userImagePath == null
                                  ? AssetImage('assets/images/img.png')
                                  : FileImage(File(value.userImagePath!)),
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Good Evening ,${value.username}",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  value.motivationQuote ??
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
                          totalTasks: value.totalTasks,
                          totalDoneTasks: value.totalDoneTasks,
                          percent: value.percent,
                        ),
                        SizedBox(height: 8),
                        HighPriorityTasksWidget(
                          tasks: value.tasks,
                          onTap: (bool? value, int? index) {
                            controller.doneTask(value, index);
                          },
                          refresh: () {
                            controller.loadTask();
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
                  value.isLoading
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
                          tasks: value.tasks,
                          primaryEmptyMessage: "No Tasks Available",
                          secondEmptyMessage:
                              "Tap 'Add New Task' to plan your day.",
                          onTap: (bool? value, int? index) {
                            controller.doneTask(value, index);
                          },
                          onDelete: (int id) {
                            controller.deleteTask(id);
                          },
                          onEdit: () => controller.loadTask(),
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
                    controller.loadTask();
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
        },
      ),
    );
  }
}
