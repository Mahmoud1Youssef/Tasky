import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/components/task_list_widget.dart';
import 'package:tasky/features/tasks/controllers/tasks_controller.dart';

class CompleteTasksScreen extends StatelessWidget {
  const CompleteTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TasksController>(
      create: (_) => TasksController()..init(),
      builder: (context, _) {
        final controller = context.read<TasksController>();

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
                child: controller.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFFFFCFC),
                          backgroundColor: Color(0xFF15B86C),
                          strokeWidth: 3,
                        ),
                      )
                    : Consumer<TasksController>(
                        builder: (BuildContext context, value, Widget? child) {
                          return TaskListWidget(
                            tasks: value.completeTasks,
                            primaryEmptyMessage: "No Completed Tasks Yet",
                            secondEmptyMessage:
                                "Tasks you check off will appear here.",
                            onTap: (value, index) async {
                              context.read<TasksController>().doneTask(
                                value,
                                index,
                                controller.completeTasks,
                              );
                            },
                            onDelete: (int id) {
                              controller.deleteTask(
                                id,
                                controller.completeTasks,
                              );
                            },
                            onEdit: () {
                              controller.init();
                            },
                          );
                        },
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
