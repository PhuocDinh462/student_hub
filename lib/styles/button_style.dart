import 'package:flutter/material.dart';
import 'package:student_hub/constants/theme.dart';

final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
    backgroundColor: primary_300,
    elevation: 0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5))));

final ButtonStyle buttonSecondary = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
    backgroundColor: text_500,
    elevation: 0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5))));
