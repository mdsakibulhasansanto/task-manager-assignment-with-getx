import 'package:flutter/material.dart';


import '../../data/models/task_model.dart';
import '../utils/app_colors.dart';

class TaskCard extends StatelessWidget {
  final TaskModel taskModel;

  const TaskCard({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.shadowColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon on top
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFEFFBEF), // light green
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.description,
              color: Colors.green,
              size: 28,
            ),
          ),

          const SizedBox(height: 12), // vertical spacing

          // Title text
          Text(
            taskModel.title ?? 'No title',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 6),

          // Description text
          Text(
            taskModel.description ?? 'No Description',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
