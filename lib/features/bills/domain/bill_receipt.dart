/// Domain model representing a verified bill or receipt in the Receipt Radar.
class BillReceipt {
  const BillReceipt({
    required this.id,
    required this.title,
    required this.providerName,
    required this.category,
    required this.paymentMethod,
    required this.status,
    required this.statusBadge,
    required this.amount,
    this.currency = 'PKR',
    required this.dateTime,
    required this.formattedDate,
    required this.ocrSnippet,
    required this.accountTitle,
    this.receiptHash,
    this.ocrConfidence = 0.98,
    this.thumbnailUri,
    this.associatedTransactionId,
  });

  final String id;
  final String title;
  final String providerName; // e.g. "1BILL - Invoice", "Raast Transfer"
  final String category; // e.g. "1BILL Utility", "Raast P2P"
  final String paymentMethod; // e.g. "PAID VIA HBL", "SENT VIA RAAST"
  final String status; // e.g. "PAID"
  final String statusBadge; // e.g. "STAMP DETECTED", "RAAST MATCHED"
  final double amount;
  final String currency;
  final DateTime dateTime;
  final String formattedDate;
  final String ocrSnippet; // e.g. "# TXN 98234710 - IESCO UTILITY"
  final String accountTitle; // e.g. "CONSUMER NO: 0411234901234"
  final String? receiptHash;
  final double? ocrConfidence;
  final String? thumbnailUri;
  final String? associatedTransactionId;

  // Backwards compatibility getters
  String get date => formattedDate;
  String get formattedAmount => '$currency ${amount.toStringAsFixed(0)}';
}
