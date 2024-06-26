
import 'package:intl/intl.dart';

class TextFormatter {

  static final _formatRealPattern = NumberFormat.currency(locale: "pt_BT", symbol: r"R$");

  TextFormatter._();
  
  static String formatReal(double value) {
    return _formatRealPattern.format(value);
  }
}