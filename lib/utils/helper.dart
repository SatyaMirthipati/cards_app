import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Helper {
  static final currency = NumberFormat("#,##0.00", "en_US");

  static const statuses = {
    'IN_PROGRESS': 'In Progress',
    'COMPLETED': 'Completed',
  };
}

class CapitalizeEachWordFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.split(' ').map(
        (word) {
          if (word.isNotEmpty) {
            return '${word[0].toUpperCase()}${word.substring(1)}';
          } else {
            return '';
          }
        },
      ).join(' '),
      selection: newValue.selection,
    );
  }
}

extension StringCasingExtension on String {
  String toCapitalized() {
    return length > 0
        ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}'
        : '';
  }

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

extension E on String {
  String lastChars(int n) => substring(length - n);
}
