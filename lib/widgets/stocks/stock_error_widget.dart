import 'package:flutter/material.dart';
import 'package:order3000_flutter/constants/colors.dart';

class StockErrorWidget extends StatelessWidget {
  final String message;

  const StockErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: AppColors.redColor),
          const SizedBox(width: 8),
          Text(
            'Error: $message',
            style: const TextStyle(
              color: AppColors.redColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
