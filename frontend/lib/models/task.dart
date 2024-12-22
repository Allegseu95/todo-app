class Task {
  int id;
  String name;
  bool completed;
  bool deleted;

  Task(
      {required this.id,
      required this.name,
      this.completed = false,
      this.deleted = false});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      completed: json['completed'],
      deleted: json['deleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'completed': completed,
      'deleted': deleted,
    };
  }
}
