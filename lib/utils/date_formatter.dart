import 'package:intl/intl.dart';

extension FormatDate on DateTime {
  String getDate() {
    return DateFormat('d/MM/yyyy').format(this).toString();
  }
}
