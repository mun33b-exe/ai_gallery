import 'package:flutter/material.dart';

class CategorySplit {
  const CategorySplit({
    required this.name,
    required this.percentage,
    required this.amount,
    required this.color,
  });

  final String name; // e.g. "1BILL Utility"
  final int percentage; // e.g. 50
  final double amount; // e.g. 1510.0
  final Color color;
}

class ReceiptRadarSummary {
  const ReceiptRadarSummary({
    required this.monthLabel,
    required this.totalSlips,
    required this.paidOutflow,
    this.currency = 'PKR',
    this.autoSynced = true,
    required this.categorySplits,
    this.scannedCount = 2,
    this.verifiedStatusText = '2 Slips Verified',
    this.miniBarChartValues = const [0.35, 0.65, 0.45, 0.90, 0.55, 0.75, 1.0],
  });

  final String monthLabel;
  final int totalSlips;
  final double paidOutflow;
  final String currency;
  final bool autoSynced;
  final List<CategorySplit> categorySplits;
  final int scannedCount;
  final String verifiedStatusText;
  final List<double> miniBarChartValues;

  String get formattedOutflow =>
      '$currency ${paidOutflow.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
}
