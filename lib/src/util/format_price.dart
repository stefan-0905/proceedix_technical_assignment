import 'dart:io';

import 'package:intl/intl.dart';

String formatWithCurrency(double number, {String symbol = '\$'}) =>
    NumberFormat.currency(locale: Platform.localeName, symbol: symbol)
        .format(number);
