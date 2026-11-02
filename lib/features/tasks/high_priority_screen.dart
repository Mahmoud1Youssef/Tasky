import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/tasks/controllers/tasks_controller.dart';
import '../../core/components/task_list_widget.dart';

class HighPriorityScreen extends StatelessWidget {
  const HighPriorityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TasksController>(
      create: (_) => TasksController()..init(),
      builder: (context, _) {
        final controller = context.read<TasksController>();

        return Scaffold(
          appBar: AppBar(title: Text("High Priority Tasks")),
          body: Padding(
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
                        tasks: value.highPriorityTasks,
                        primaryEmptyMessage: "No Pending Tasks",
                        secondEmptyMessage:
                            "You're all set! Add new tasks whenever you're ready.",
                        onTap: (value, index) async {
                          controller.doneTask(
                            value,
                            index,
                            controller.highPriorityTasks,
                          );
                        },
                        onDelete: (int id) {
                          controller.deleteTask(
                            id,
                            controller.highPriorityTasks,
                          );
                        },
                        onEdit: () {
                          controller.init();
                        },
                      );
                    },
                  ),
          ),
        );
      },
    );
  }
}
