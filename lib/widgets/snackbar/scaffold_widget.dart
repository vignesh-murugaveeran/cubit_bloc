import 'package:flutter/material.dart';

void scaffoldSnackbar(BuildContext context, String snackBarText) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(snackBarText)));
}
