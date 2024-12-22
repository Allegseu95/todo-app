import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// providers
import '../providers/task.dart';

// constants
import '../constants/colors.dart';

class TaskForm extends StatelessWidget {
  const TaskForm({super.key});

  @override
  Widget build(BuildContext context) {
    String newTaskName = '';

    void addTask() {
      if (newTaskName.isEmpty) {
        return;
      }

      final taskProvider = Provider.of<TaskProvider>(context, listen: false);

      taskProvider.addTask(newTaskName);

      Navigator.pop(context);
    }

    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Nueva Tarea',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) => newTaskName = value,
              decoration: InputDecoration(
                hintText: 'Nombre de la tarea',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: mediumGreen),
                ),
                filled: true,
                fillColor: offWhite,
                contentPadding: const EdgeInsets.all(14),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: red,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(fontSize: 16, color: offWhite),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: addTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mediumGreen,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: const Text(
                    'Crear Tarea',
                    style: TextStyle(fontSize: 16, color: offWhite),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
