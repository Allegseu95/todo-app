import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// providers
import '../providers/task.dart';

// widgets
import '../widgets/center_text.dart';
import '../widgets/task_card.dart';
import '../widgets/task_form.dart';

// constants
import '../constants/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      if (mounted) {
        await Provider.of<TaskProvider>(context, listen: false).loadTasks();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: offWhite,
        child: Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            return taskProvider.tasks.isEmpty
                ? CenterText(
                    message: 'Listado Vacío',
                    icon: Icons.inbox,
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 50, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Listado de Tareas',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: darkGreen),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/chart'),
                          style: ElevatedButton.styleFrom(
                            shadowColor: darkGreen,
                            backgroundColor: pureWhite,
                          ),
                          child: const Text(
                            'Visualizar Gráfica',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: darkGreen),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: taskProvider.activeTasks.length,
                            itemBuilder: (context, index) => TaskCard(
                              task: taskProvider.activeTasks[index],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const TaskForm(),
        ),
        backgroundColor: mediumGreen,
        foregroundColor: pureWhite,
        elevation: 10,
        child: const Icon(Icons.add),
      ),
    );
  }
}
