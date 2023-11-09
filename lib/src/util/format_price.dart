import 'package:intl/intl.dart';

String formatWithCurrency(double number, {String symbol = '\$'}) {
  return NumberFormat.currency(locale: 'en', symbol: symbol).format(number);
}
