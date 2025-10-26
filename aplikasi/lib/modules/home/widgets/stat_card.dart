import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color textColor;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.textColor,
  });

  Color _getBackgroundColor(Color textColor) {
    if (textColor == Colors.blue) return Colors.blue.shade50;
    if (textColor == Colors.green) return Colors.green.shade50;
    return Colors.grey.shade100;
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isTablet ? 24 : 16,
        horizontal: isTablet ? 20 : 12,
      ),
      decoration: BoxDecoration(
        color: _getBackgroundColor(textColor),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: isTablet ? 26 : 22,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: isTablet ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }
}