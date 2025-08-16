import 'package:flutter/material.dart';
import 'package:order3000_flutter/constants/colors.dart';
import 'package:order3000_flutter/widgets/search_bar.dart';

class StockSearchSection extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onFetch;

  const StockSearchSection({
    super.key,
    required this.controller,
    required this.onFetch,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(child: StockSearchWidget(controller: controller)),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              onPressed: onFetch,
              icon: const Icon(Icons.search),
              label: const Text('Fetch'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.amberColor,
                foregroundColor: AppColors.blackColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
