import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/custom_check_box.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/build_empty_state_widget.dart';
import 'package:tasky/widgets/task_item_widget.dart';

import '../core/theme/theme_controller.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.primaryEmptyMessage,
    required this.secondEmptyMessage,
    required this.onDelete,
    required this.onEdit,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function(int) onDelete;
  final Function onEdit;
  final String? primaryEmptyMessage;
  final String? secondEmptyMessage;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? SliverToBoxAdapter(
            child: BuildEmptyStateWidget(
              primaryEmptyMessage: primaryEmptyMessage,
              secondEmptyMessage: secondEmptyMessage,
            ),
          )
        : SliverPadding(
            padding: EdgeInsets.only(bottom: 80),
            sliver: SliverList.separated(
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return TaskItemWidget(
                  model: tasks[index],
                  onChanged: (bool? value) {
                    onTap(value, index);
                  },
                  onDelete: (int id) {
                    onDelete(id);
                  },
                  onEdit: () => onEdit(),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 8);
              },
            ),
          );
  }
}
