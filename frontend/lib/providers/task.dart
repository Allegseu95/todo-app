import 'package:flutter/material.dart';

// services
import '../services/task.dart';

// models
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  List<Task> get activeTasks => _tasks.where((task) => !task.deleted).toList()
    ..sort((a, b) => b.id.compareTo(a.id));

  Future<void> addTask(String name) async {
    try {
      final newTask = await TaskService().register(name);

      _tasks.add(newTask);

      notifyListeners();
    } catch (error) {
      print('Error register newTask: $error');
    }
  }

  Future<void> completeTask(int id) async {
    try {
      final updatedTask = await TaskService().completeTask(id);

      final taskIndex = _tasks.indexWhere((task) => task.id == updatedTask.id);

      if (taskIndex == -1) return;

      _tasks[taskIndex] = updatedTask;

      notifyListeners();
    } catch (error) {
      print('Error complete task: $error');
    }
  }

  Future<void> deleteTask(int id) async {
    try {
      final updatedTask = await TaskService().deleteTask(id);

      final taskIndex = _tasks.indexWhere((task) => task.id == updatedTask.id);

      if (taskIndex == -1) return;

      _tasks[taskIndex] = updatedTask;

      notifyListeners();
    } catch (error) {
      print('Error delete task: $error');
    }
  }

  Future<void> loadTasks() async {
    try {
      _tasks = await TaskService().getAll();

      notifyListeners();
    } catch (error) {
      print('Error loading tasks: $error');
    }
  }

  Map<String, int> getStatistics() {
    final completedCount =
        _tasks.where((item) => item.completed && !item.deleted).length;

    final noCompletedCount =
        _tasks.where((item) => !item.completed && !item.deleted).length;

    final deletedCount = _tasks.where((item) => item.deleted).length;

    return {
      'completed': completedCount,
      'noCompleted': noCompletedCount,
      'deleted': deletedCount,
    };
  }
}
