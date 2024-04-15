import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
}
