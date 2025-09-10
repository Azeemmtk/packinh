import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../domain/entity/dashboard_data.dart';

class FinancialChart extends StatelessWidget {
  final DashboardData data;
  const FinancialChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final maxY =
        (data.receivedAmount + data.pendingAmount + data.expenses) * 1.2;

    return Container(
      height: 250,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 1)
        ],
      ),
      child: BarChart(
        BarChartData(
          maxY: maxY < 1 ? 100 : maxY,
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.grey.withOpacity(0.2),
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          titlesData: FlTitlesData(
            show: true,
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 35,
                getTitlesWidget: (value, meta) => Text(
                  value.toInt().toString(),
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ),
            rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return const Text('Received',
                          style: TextStyle(fontSize: 12));
                    case 1:
                      return const Text('Pending',
                          style: TextStyle(fontSize: 12));
                    case 2:
                      return const Text('Expenses',
                          style: TextStyle(fontSize: 12));
                    default:
                      return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
          barGroups: [
            _buildGroup(0, data.receivedAmount, Colors.green),
            _buildGroup(1, data.pendingAmount, Colors.red),
            _buildGroup(2, data.expenses, Colors.blue),
          ],
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                String label;
                switch (group.x.toInt()) {
                  case 0:
                    label = 'Received';
                    break;
                  case 1:
                    label = 'Pending';
                    break;
                  case 2:
                    label = 'Expenses';
                    break;
                  default:
                    label = '';
                }
                return BarTooltipItem(
                  "$label\n${rod.toY.toStringAsFixed(2)}",
                  const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  BarChartGroupData _buildGroup(int x, double value, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 25,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
        )
      ],
    );
  }
}
