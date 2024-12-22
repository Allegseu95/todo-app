import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

// providers
import '../providers/task.dart';

// utils
import '../utils/web_socket.dart';

// constants
import '../constants/colors.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPage();
}

class _ChartPage extends State<ChartPage> {
  late WebSocketService _webSocketService;

  int completedCount = 0;
  int notCompletedCount = 0;
  int deletedCount = 0;

  @override
  void initState() {
    super.initState();

    _webSocketService = WebSocketService();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      final statistics = taskProvider.getStatistics();

      setState(() {
        completedCount = statistics['completed'] ?? 0;
        notCompletedCount = statistics['noCompleted'] ?? 0;
        deletedCount = statistics['deleted'] ?? 0;
      });
    });

    _webSocketService.messages.listen((message) {
      try {
        final Map<String, dynamic> messageData = jsonDecode(message);

        setState(() {
          completedCount = messageData['completed'] ?? 0;
          notCompletedCount = messageData['noCompleted'] ?? 0;
          deletedCount = messageData['deleted'] ?? 0;
        });
      } catch (e) {
        print('Error al procesar el mensaje: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: offWhite,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Gráfica de Tareas',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: darkGreen),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/'),
                style: ElevatedButton.styleFrom(
                  shadowColor: darkGreen,
                  backgroundColor: pureWhite,
                ),
                child: const Text(
                  'Ir al Listado de Tareas',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: darkGreen),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Tareas Completadas: $completedCount',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: darkGreen,
                ),
              ),
              Text(
                'Tareas No Completadas: $notCompletedCount',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: cyan,
                ),
              ),
              Text(
                'Tareas Eliminadas: $deletedCount',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: red,
                ),
              ),
              Expanded(
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: completedCount.toDouble(),
                        title: '$completedCount',
                        color: darkGreen,
                        radius: 90,
                        titleStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      PieChartSectionData(
                        value: notCompletedCount.toDouble(),
                        title: '$notCompletedCount',
                        color: cyan,
                        radius: 90,
                        titleStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      PieChartSectionData(
                        value: deletedCount.toDouble(),
                        title: '$deletedCount',
                        color: red,
                        radius: 90,
                        titleStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                    sectionsSpace: 5,
                    centerSpaceRadius: 90,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
