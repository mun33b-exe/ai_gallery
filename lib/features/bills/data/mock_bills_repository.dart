import 'package:flutter/material.dart';

import '../domain/bill_receipt.dart';
import '../domain/receipt_radar_summary.dart';

abstract class BillsRepository {
  Future<ReceiptRadarSummary> fetchReceiptRadarSummary();
  Future<List<BillReceipt>> fetchBills();
}

class MockBillsRepository implements BillsRepository {
  const MockBillsRepository();

  @override
  Future<ReceiptRadarSummary> fetchReceiptRadarSummary() async {
    return const ReceiptRadarSummary(
      monthLabel: 'Jun 2026',
      totalSlips: 2,
      paidOutflow: 3010.0,
      currency: 'PKR',
      autoSynced: true,
      categorySplits: [
        CategorySplit(
          name: '1BILL Utility 50%',
          percentage: 50,
          amount: 1510.0,
          color: Color(0xFF55C481), // emerald green
        ),
        CategorySplit(
          name: 'Raast P2P 50%',
          percentage: 50,
          amount: 1500.0,
          color: Color(0xFF006496), // secondary blue
        ),
      ],
      scannedCount: 2,
      verifiedStatusText: '2 Slips Verified',
      miniBarChartValues: [0.25, 0.40, 0.95, 0.95],
    );
  }

  @override
  Future<List<BillReceipt>> fetchBills() async {
    return [
      BillReceipt(
        id: '19112764039',
        title: '1BILL - Invoice',
        providerName: '1BILL - Invoice',
        category: '1BILL Utility',
        paymentMethod: 'PAID VIA HBL',
        status: 'PAID',
        statusBadge: 'STAMP DETECTED',
        amount: 1510.0,
        currency: 'PKR',
        dateTime: DateTime(2026, 6, 28, 18, 50),
        formattedDate: '28 Jun 2026',
        ocrSnippet: '#1006872607',
        accountTitle: 'ID: 19112764039',
        receiptHash: '19112764039',
        ocrConfidence: 0.998,
        associatedTransactionId: '19112764039',
      ),
      BillReceipt(
        id: '18422998880',
        title: 'Raast Transfer · Javeria Amin',
        providerName: 'Raast Transfer · Javeria Amin',
        category: 'Raast P2P',
        paymentMethod: 'SENT VIA RAAST',
        status: 'MATCHED',
        statusBadge: 'RAAST MATCHED',
        amount: 1500.0,
        currency: 'PKR',
        dateTime: DateTime(2026, 4, 29, 11, 20),
        formattedDate: '29 Apr 2026',
        ocrSnippet: 'TXN: 18422998880',
        accountTitle: 'To: JAVERIA AMIN',
        receiptHash: '18422998880',
        ocrConfidence: 0.985,
        associatedTransactionId: '18422998880',
      ),
    ];
  }
}
