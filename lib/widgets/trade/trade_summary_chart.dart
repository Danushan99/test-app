// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:order3000_flutter/models/trade_summary_model.dart';


// class TradeSummaryChart extends StatelessWidget {
//   final List<TradeSummary> summaries;

//   const TradeSummaryChart({super.key, required this.summaries});

//   @override
//   Widget build(BuildContext context) {
//     if (summaries.isEmpty) {
//       return const Center(child: Text("No data available"));
//     }

//     return SizedBox(
//       height: 300,
//       child: BarChart(
//         BarChartData(
//           alignment: BarChartAlignment.spaceAround,
//           maxY: summaries.map((e) => e.price).reduce((a, b) => a > b ? a : b) * 1.2,
//           barTouchData: BarTouchData(enabled: true),
//           titlesData: FlTitlesData(
//             leftTitles: AxisTitles(
//               sideTitles: SideTitles(showTitles: true),
//             ),
//             bottomTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 getTitlesWidget: (value, meta) {
//                   int index = value.toInt();
//                   if (index < 0 || index >= summaries.length) return const SizedBox.shrink();
//                   return Text(
//                     summaries[index].symbol,
//                     style: const TextStyle(fontSize: 10),
//                   );
//                 },
//               ),
//             ),
//           ),
//           barGroups: List.generate(summaries.length, (index) {
//             final item = summaries[index];
//             return BarChartGroupData(
//               x: index,
//               barRods: [
//                 BarChartRodData(
//                   toY: item.price,
//                   width: 16,
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//               ],
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:order3000_flutter/models/trade_summary_model.dart';


class TradeSummaryChart extends StatelessWidget {
  final List<TradeSummary> summaries;

  const TradeSummaryChart({super.key, required this.summaries});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Top Traded Securities",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Chart
            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 42,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < 0 || index >= summaries.length) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              summaries[index].symbol,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: summaries.asMap().entries.map((entry) {
                    final index = entry.key;
                    final summary = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: summary.volume.toDouble(),
                          color: summary.change >= 0 ? Colors.green : Colors.red,
                          width: 18,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
