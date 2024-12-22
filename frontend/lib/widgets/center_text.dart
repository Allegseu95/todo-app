import 'package:flutter/material.dart';

// constants
import '../constants/colors.dart';

class CenterText extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color color;

  const CenterText({
    super.key,
    required this.message,
    this.icon = Icons.message,
    this.color = darkGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 70,
            color: color,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
