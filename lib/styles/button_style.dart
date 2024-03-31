import 'package:flutter/material.dart';
import 'package:student_hub/constants/theme.dart';

final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
    backgroundColor: primary_300,
    elevation: 0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5))));

final ButtonStyle buttonSecondary = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
    backgroundColor: color_1,
    textStyle: const TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
    elevation: 0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5))));
