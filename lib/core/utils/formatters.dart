import 'package:intl/intl.dart';

/// Formatting utilities for currency and dates.
abstract final class Formatters {
  static final NumberFormat _currencyFormat = NumberFormat('#,##0', 'en_US');
  static final DateFormat _dateFormat = DateFormat('MMM d, yyyy');
  static final DateFormat _shortDateFormat = DateFormat('MMM d');

  /// Formats an amount with currency symbol, e.g. "PKR 5,000".
  static String formatCurrency(double amount, [String currency = 'PKR']) {
    final formatted = _currencyFormat.format(amount.abs());
    return '$currency $formatted';
  }

  /// Formats an amount with +/- indicator, e.g. "-PKR 5,000" or "+PKR 4,000".
  static String formatSignedCurrency(
    double amount, {
    bool isExpense = false,
    String currency = 'PKR',
  }) {
    final prefix = isExpense ? '-' : '+';
    return '$prefix${formatCurrency(amount, currency)}';
  }

  /// Formats a DateTime to "Oct 5, 2026".
  static String formatDate(DateTime date) {
    return _dateFormat.format(date);
  }

  /// Formats a DateTime to "Oct 5".
  static String formatShortDate(DateTime date) {
    return _shortDateFormat.format(date);
  }
}
