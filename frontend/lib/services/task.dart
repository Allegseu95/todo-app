// utils
import '../utils/http.dart';

// models
import '../models/task.dart';

class TaskService {
  final HttpService _httpService;

  TaskService._internal(this._httpService);

  static final TaskService _instance = TaskService._internal(HttpService());

  factory TaskService() {
    return _instance;
  }

  Future<List<Task>> getAll() async {
    try {
      final response = await _httpService.get('/api/todo');

      final tasks = response['data'].map((task) => Task.fromJson(task));

      return List<Task>.from(tasks);
    } catch (error) {
      rethrow;
    }
  }

  Future<Task> register(String name) async {
    try {
      final response = await _httpService.post('/api/todo', {"name": name});

      return Task.fromJson(response);
    } catch (error) {
      rethrow;
    }
  }

  Future<Task> completeTask(int taskId) async {
    try {
      final response = await _httpService.put('/api/todo/complete/$taskId');

      return Task.fromJson(response);
    } catch (error) {
      rethrow;
    }
  }

  Future<Task> deleteTask(int taskId) async {
    try {
      final response = await _httpService.put('/api/todo/delete/$taskId');

      return Task.fromJson(response);
    } catch (error) {
      rethrow;
    }
  }
}
