import 'package:flutter/material.dart';

class NetProfitWidget extends StatelessWidget {
  final double netProfit;
  const NetProfitWidget({super.key, required this.netProfit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Net Profit/Loss:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        Text(
          netProfit >= 0 ? "+${netProfit.toStringAsFixed(0)}" : netProfit.toStringAsFixed(0),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: netProfit >= 0 ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }
}
  