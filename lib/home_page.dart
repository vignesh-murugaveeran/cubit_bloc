import 'package:bloc_learning/auth/auth_cubit.dart';
import 'package:bloc_learning/auth/auth_state.dart';
import 'package:bloc_learning/widgets/loader/circ_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:bloc_learning/widgets/snackbar/scaffold_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.authState == AuthStatus.initial) {
            Navigator.of(context).pop();
            scaffoldSnackbar(context, state.resMessage!);
          }
        },
        builder: (context, state) {
          final isLoading = state.authState == AuthStatus.loading;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Welcome to home page!"),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await context.read<AuthCubit>().logout();
                  },
                  child: isLoading
                      ? circularLoader()
                      : const Text("Logout"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
