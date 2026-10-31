import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/widgets/custom_check_box.dart';
import 'package:tasky/features/home/home_controller.dart';
import '../../../core/theme/theme_controller.dart';
import '../../tasks/high_priority_screen.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  const HighPriorityTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder:
          (BuildContext context, HomeController controller, Widget? child) {
            final tasksList = controller.tasks;

            return Container(
              width: double.infinity,
              padding: EdgeInsets.only(right: 16, left: 16, bottom: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: ThemeController.isDark()
                      ? Colors.transparent
                      : Color(0xFFD1DAD6),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            "High Priority Tasks",
                            style: TextStyle(
                              color: Color(0xFF15B86C),
                              fontSize: 14,
                              fontWeight: FontWeight(400),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        ...tasksList.reversed
                            .where((e) => e.isHighPriority)
                            .take(4)
                            .map((element) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  children: [
                                    CustomCheckBox(
                                      value: element.isDone,
                                      onChanged: (bool? value) {
                                        final index = tasksList.indexWhere(
                                          (e) => e.id == element.id,
                                        );
                                        controller.doneTask(value, index);
                                      },
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        element.taskName,
                                        style: element.isDone
                                            ? Theme.of(
                                                context,
                                              ).textTheme.titleLarge
                                            : Theme.of(
                                                context,
                                              ).textTheme.titleMedium,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return HighPriorityScreen();
                          },
                        ),
                      );
                      controller.totalTasks;
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        bottom: 8.0,
                        top: 12,
                      ),
                      child: Container(
                        width: 40,
                        height: 40,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: ThemeController.isDark()
                                ? Color(0xFF6E6E6E)
                                : Color(0xFFD1DAD6),
                            width: 1,
                          ),
                        ),
                        child: SvgPicture.asset(
                          'assets/images/arrow_up_right.svg',
                          colorFilter: ColorFilter.mode(
                            ThemeController.isDark()
                                ? Color(0xFFC6C6C6)
                                : Color(0xFF3A4640),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
    );
  }
}
