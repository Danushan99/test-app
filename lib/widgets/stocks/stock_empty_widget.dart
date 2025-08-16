import 'package:flutter/material.dart';
import 'package:order3000_flutter/constants/colors.dart';

class StockEmptyWidget extends StatelessWidget {
  const StockEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline, color: AppColors.grayColor, size: 40),
          SizedBox(height: 8),
          Text(
            'Enter a stock symbol to fetch data',
            style: TextStyle(color: AppColors.grayColor, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
