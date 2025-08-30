import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<DateTime?> datePicker(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2101),
  );
  return picked;

}
