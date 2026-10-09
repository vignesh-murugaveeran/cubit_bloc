import 'package:flutter/material.dart';

Widget circularLoader() {
  return const SizedBox(
    width: 15,
    height: 15,
    child: CircularProgressIndicator(strokeWidth: 1.7),
  );
}
