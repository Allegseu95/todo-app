import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// providers
import '../providers/task.dart';

// models
import '../models/task.dart';

// constants
import '../constants/colors.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: pureWhite,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: softGreen,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.5),
        leading: Consumer<TaskProvider>(
            builder: (context, taskProvider, child) => Checkbox(
                  value: task.completed,
                  onChanged: (_) => taskProvider.completeTask(task.id),
                  activeColor: darkGreen,
                )),
        title: Text(
          task.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            decoration: task.completed
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            color: task.completed ? lightGrey : black,
          ),
        ),
        trailing: Consumer<TaskProvider>(
          builder: (context, taskProvider, child) => IconButton(
            icon: const Icon(Icons.delete_outline, color: red),
            onPressed: () => taskProvider.deleteTask(task.id),
          ),
        ),
      ),
    );
  }
}
