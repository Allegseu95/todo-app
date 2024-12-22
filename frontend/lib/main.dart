import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// providers
import 'providers/task.dart';

// screens
import 'screens/home.dart';
import 'screens/chart.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/chart': (context) => const ChartPage(),
      },
    );
  }
}
