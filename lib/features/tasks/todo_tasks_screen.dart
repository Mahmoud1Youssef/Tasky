import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/components/task_list_widget.dart';
import 'package:tasky/features/tasks/controllers/tasks_controller.dart';

class TodoTasksScreen extends StatelessWidget {
  const TodoTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(18),
          child: Text(
            "To Do Tasks",
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
                        tasks: value.todoTasks,
                        primaryEmptyMessage: "No Pending Tasks",
                        secondEmptyMessage:
                            "You're all set! Add new tasks whenever you're ready.",
                        onTap: (value, index) async {
                          controller.doneTask(
                            value,
                            index,
                            controller.todoTasks,
                          );
                        },
                        onDelete: (int id) {
                          controller.deleteTask(id, controller.todoTasks);
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
  }
}
