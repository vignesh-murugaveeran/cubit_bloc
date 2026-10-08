import 'package:bloc_learning/widgets/snackbar/scaffold_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome to home page!"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                scaffoldSnackbar(context, "You are logout!");
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
