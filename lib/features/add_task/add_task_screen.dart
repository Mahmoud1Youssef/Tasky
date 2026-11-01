import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/features/add_task/add_task_controller.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext _) {
    return ChangeNotifierProvider<AddTaskController>(
      create: (_) => AddTaskController(),
      builder: (context, _) {
        final AddTaskController controller = context.read<AddTaskController>();
        return Scaffold(
          appBar: AppBar(title: Text("New Task")),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: controller.key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                              controller: controller.taskNameController,
                              title: "Task Name",
                              hintText: "Finish UI design for login screen",
                              maxLines: 1,
                              validator: (String? value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please Write Task Name";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            CustomTextFormField(
                              controller: controller.taskDescriptionController,
                              title: "Task Description",
                              hintText:
                                  "Finish onboarding UI and hand off to devs by Thursday.",
                              maxLines: 5,
                            ),

                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "High Priority",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Consumer<AddTaskController>(
                                  builder:
                                      (
                                        BuildContext context,
                                        value,
                                        Widget? child,
                                      ) {
                                        return Switch(
                                          value: value.isHighPriority,
                                          onChanged: (bool value) {
                                            controller.toggle(value);
                                          },
                                        );
                                      },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 40),
                      ),
                      icon: Icon(Icons.add),
                      label: Text("Add Task"),
                      onPressed: () async {
                        context.read<AddTaskController>().addTask(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
