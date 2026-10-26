import 'package:flutter/material.dart';

import '../theme/theme_controller.dart';

class BuildEmptyStateWidget extends StatelessWidget {
  const BuildEmptyStateWidget({
    super.key,
    required this.primaryEmptyMessage,
    required this.secondEmptyMessage,
  });

  final String? primaryEmptyMessage;
  final String? secondEmptyMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment_outlined, size: 64, color: Color(0xFF6D6D6D)),
          SizedBox(height: 16),
          Text(
            primaryEmptyMessage ?? "No Data",
            style: TextStyle(
              color: ThemeController.isDark()
                  ? Color(0xFFFFFCFC)
                  : Color(0xFF161F1B),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            secondEmptyMessage ?? "No Data",
            style: TextStyle(
              color: ThemeController.isDark()
                  ? Color(0xFFC6C6C6)
                  : Color(0xFF3A4640),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
