import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/home/home_controller.dart';
import 'package:tasky/core/components/build_empty_state_widget.dart';
import 'package:tasky/core/components/task_item_widget.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder:
          (BuildContext context, HomeController controller, Widget? child) {
            final tasksList = controller.tasks;

            return controller.isLoading
                ? SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFFFCFC),
                        backgroundColor: Color(0xFF15B86C),
                        strokeWidth: 3,
                      ),
                    ),
                  )
                : tasksList.isEmpty
                ? SliverToBoxAdapter(
                    child: BuildEmptyStateWidget(
                      primaryEmptyMessage: "No Tasks Available",
                      secondEmptyMessage:
                          "Tap 'Add New Task' to plan your day.",
                    ),
                  )
                : SliverPadding(
                    padding: EdgeInsets.only(bottom: 80),
                    sliver: SliverList.separated(
                      itemCount: tasksList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TaskItemWidget(
                          model: tasksList[index],
                          onChanged: (bool? value) {
                            controller.doneTask(value, index);
                          },
                          onDelete: (int id) {
                            controller.deleteTask(id);
                          },
                          onEdit: () {
                            controller.loadTask();
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 8);
                      },
                    ),
                  );
          },
    );
  }
}
