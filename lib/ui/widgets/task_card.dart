import 'package:flutter/material.dart';
import 'package:task_manager_getx/ui/widgets/show_snack_bar.dart';

import '../../data/models/task_model.dart';
import '../../data/services/network_caller.dart';
import 'centered_circular_progress_indicator.dart';
import 'package:task_manager_getx/data/urls/task_urls.dart';


enum TaskType { tNew, progress, completed, cancelled }

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskType,
    required this.taskModel,
    required this.onStatusUpdate,
    this.onDelete, // Add onDelete callback
  });

  final TaskType taskType;
  final TaskModel taskModel;
  final VoidCallback onStatusUpdate;
  final VoidCallback? onDelete;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _updateTaskStatusInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title,
              style: Theme
                  .of(context)
                  .textTheme
                  .titleMedium,
            ),
            Text(
              widget.taskModel.description,
              style: const TextStyle(color: Colors.black54),
            ),
            Text('Date: ${widget.taskModel.createdDate}'),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(
                  label: Text(
                    _getTaskTypeName(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  backgroundColor: _getTaskChipColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide.none,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: _deleteTask, // Implement delete logic
                  icon: const Icon(Icons.delete),
                ),
                Visibility(
                  visible: !_updateTaskStatusInProgress,
                  replacement: CenteredCircularProgressIndicator(),
                  child: IconButton(
                    onPressed: _showEditTaskStatusDialog,
                    icon: const Icon(Icons.edit),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getTaskChipColor() {
    switch (widget.taskType) {
      case TaskType.tNew:
        return Colors.blue;
      case TaskType.progress:
        return Colors.purple;
      case TaskType.completed:
        return Colors.green;
      case TaskType.cancelled:
        return Colors.red;
    }
  }

  String _getTaskTypeName() {
    switch (widget.taskType) {
      case TaskType.tNew:
        return 'New';
      case TaskType.progress:
        return 'Progress';
      case TaskType.completed:
        return 'Completed';
      case TaskType.cancelled:
        return 'Cancelled';
    }
  }

  void _showEditTaskStatusDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Change Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('New'),
                trailing: _getTaskStatusTrailing(TaskType.tNew),
                onTap: () {
                  Navigator.pop(context);
                  if (widget.taskType != TaskType.tNew) {
                    _updateTaskStatus('New');
                  }
                },
              ),
              ListTile(
                title: const Text('In Progress'),
                trailing: _getTaskStatusTrailing(TaskType.progress),
                onTap: () {
                  Navigator.pop(context);
                  if (widget.taskType != TaskType.progress) {
                    _updateTaskStatus('Progress');
                  }
                },
              ),
              ListTile(
                title: const Text('Completed'),
                trailing: _getTaskStatusTrailing(TaskType.completed),
                onTap: () {
                  Navigator.pop(context);
                  if (widget.taskType != TaskType.completed) {
                    _updateTaskStatus('Completed');
                  }
                },
              ),
              ListTile(
                title: const Text('Cancelled'),
                trailing: _getTaskStatusTrailing(TaskType.cancelled),
                onTap: () {
                  Navigator.pop(context);
                  if (widget.taskType != TaskType.cancelled) {
                    _updateTaskStatus('Cancelled');
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget? _getTaskStatusTrailing(TaskType type) {
    return widget.taskType == type ? const Icon(Icons.check) : null;
  }

  Future<void> _updateTaskStatus(String status) async {
    _updateTaskStatusInProgress = true;
    if (mounted) setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(
      url: TaskUrls.updateTaskStatusUrl(widget.taskModel.id, status),
    );
    _updateTaskStatusInProgress = false;
    if (mounted) setState(() {});
    if (response.isSuccess) {
      widget.onStatusUpdate();
    } else {
      if (mounted && response.errorMessage != null) {
        showSnackBarMessage(context, response.errorMessage!);
      }
    }
  }

  Future<void> _deleteTask() async {
    _updateTaskStatusInProgress = true;
    if (mounted) setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(
      url: TaskUrls.deleteTaskUrl(widget.taskModel.id),
    );
    _updateTaskStatusInProgress = false;
    if (mounted) setState(() {});
    if (response.isSuccess) {
      widget.onDelete?.call();
    } else {
      if (mounted && response.errorMessage != null) {
        showSnackBarMessage(context, response.errorMessage!);
      }
    }
  }

}
