  import 'package:flutter/widgets.dart';
import 'package:order3000_flutter/constants/colors.dart';

Widget IconDetailRow(
      IconData icon, String title, dynamic value, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child:
                Text(title, style: const TextStyle(color: AppColors.grayColor)),
          ),
          Text(
            value != null ? value.toString() : '-',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }