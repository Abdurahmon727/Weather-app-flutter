import 'dart:core' as core;
import 'dart:core';

import 'package:intl/intl.dart';

extension DateTime on int {
  String toHour() {
    var now = core.DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = core. DateTime.fromMicrosecondsSinceEpoch(this * 1000);
    var diff = date.difference(now);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + 'DAY AGO';
      } else {
        time = diff.inDays.toString() + 'DAYS AGO';
      }
    }

    return time;
  }
}
