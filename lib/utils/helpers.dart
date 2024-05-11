import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Helpers {
  Helpers._();
  static String timeToString(TimeOfDay time) {
    try {
      final DateTime now = DateTime.now();
      final date = DateTime(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute,
      );
      return DateFormat.jm().format(date);
    } catch (e) {
      return '12:00 pm';
    }
  }

  static DateTime formatMMYYYYToDateTime(String dateStr) {
    List<String> parts = dateStr.split('-');
    return DateTime.parse('${parts[1]}-${parts[0]}-01');
  }

  static String formatDateTimeToMMYYYY(DateTime dateTime) {
    return DateFormat('MM-yyyy').format(dateTime);
  }

  static String formatMMYYYTToString(String dateStr) {
    List<String> parts = dateStr.split('-');
    return '${parts[0]}/${parts[1]}';
  }

  static int calculateMonthsBetween(String dateStr1, String dateStr2) {
    DateTime date1 = formatMMYYYYToDateTime(dateStr1);
    DateTime date2 = formatMMYYYYToDateTime(dateStr2);

    return (date2.year - date1.year) * 12 + date2.month - date1.month;
  }

  static List<String> getFileNameAndExtension(String name) {
    List<String> parts = name.split('/');
    String filenameWithPrefix = parts.last;
    String fileName = filenameWithPrefix.replaceFirst(RegExp(r'^\d+-'), '');

    return getFileNameAndExtension2(fileName);
  }

  static List<String> getFileNameAndExtension2(String name) {
    List<String> parts2 = name.split('.');
    String extension = parts2.last;
    String nameStr = name.substring(0, name.length - extension.length - 1);

    return [nameStr, extension];
  }

  static String calculateTimeFromNow(String dateString, BuildContext context) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);

    if (difference.inDays > 10) {
      return '${date.day}/${date.month}/${date.year}';
    } else if (difference.inDays > 0 && difference.inDays <= 10) {
      return '${difference.inDays} ${AppLocalizations.of(context)!.daysAgo}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${AppLocalizations.of(context)!.hoursAgo}';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${AppLocalizations.of(context)!.mintesAgo}';
    } else {
      return '${difference.inSeconds} ${AppLocalizations.of(context)!.secondsAgo}';
    }
  }

  static String formatTime(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    DateFormat timeFormat = DateFormat('HH:mm');
    DateFormat dateFormat = DateFormat('dd/MM');

    // Find the first and last day of the current week
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    if (date.day == now.day &&
        date.month == now.month &&
        date.year == now.year) {
      return timeFormat.format(date);
    } else if (date.isAfter(startOfWeek) && date.isBefore(endOfWeek)) {
      if (date.weekday == 7) {
        return 'CN';
      } else {
        return 'T.${date.weekday + 1}';
      }
    } else {
      return dateFormat.format(date);
    }
  }

  static String formatDateTimeToCustom(String dateString) {
    DateTime date = DateTime.parse(dateString);

    return DateFormat('HH:mm - dd/MM/yyyy').format(date);
  }
}
