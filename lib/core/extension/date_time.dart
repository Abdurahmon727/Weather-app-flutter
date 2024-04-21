import 'dart:core' as core;
import 'dart:core';

import 'package:intl/intl.dart';

extension DateTime on num {
  String toHour() {
    final dt = this.toInt();

    // Create a DateTime object from the Unix timestamp
    final dateTime = core.DateTime.fromMicrosecondsSinceEpoch(dt * 1000000);

    // Use DateFormat to format the time in HH:mm (24-hour format)
    final formatter = DateFormat('HH:mm');
    return formatter.format(dateTime);
  }

  String toDay(String locale) {
    final dt = this.toInt();

    // Create a DateTime object from the Unix timestamp
    final dateTime = core.DateTime.fromMicrosecondsSinceEpoch(dt * 1000000);

    // Use DateFormat to format the time in HH:mm (24-hour format)
    final formatter = DateFormat('d-MMMM', locale);
    return formatter.format(dateTime);
  }
}
