import 'package:bloc_learning/auth/auth_cubit.dart';
import 'package:bloc_learning/auth/auth_state.dart';
import 'package:bloc_learning/home_page.dart';
import 'package:bloc_learning/widgets/snackbar/scaffold_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
* Title: BlocBuilder, BlocListener, and BlocConsumer
* BlocBuilder -> similar to the Obx() in getx.
* BlocListener -> based on state changes, it will do the action.
* BlocConsumer -> BlocBuilder + BlocListener.
*/
void main() {
  //create: (context) => AuthCubit() ---> Make a AuthCubit available to this widget tree(MyApp()).
  runApp(BlocProvider(create: (context) => AuthCubit(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.lightBlue)),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'BLoC Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  void login() {
    context.read<AuthCubit>().login(
      email: emailTextController.text.trim(),
      password: passwordTextController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.authState == AuthStatus.success) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
            scaffoldSnackbar(context, state.resMessage!);
            // ScaffoldMessenger.of(
            //   context,
            // ).showSnackBar(SnackBar(content: Text(state.resMessage!)));
          } else if (state.authState == AuthStatus.error) {
            scaffoldSnackbar(context, state.resMessage!);
            // ScaffoldMessenger.of(
            //   context,
            // ).showSnackBar(SnackBar(content: Text(state.resMessage!)));
          }
        },
        builder: (context, state) {
          final isLoading = state.authState == AuthStatus.loading;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                TextFieldWidget(
                  controller: emailTextController,
                  keyboardTextType: TextInputType.emailAddress,
                  textHint: 'Email',
                ),
                const SizedBox(height: 20),
                TextFieldWidget(
                  controller: passwordTextController,
                  keyboardTextType: TextInputType.visiblePassword,
                  textHint: 'Password',
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: isLoading ? null : login,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(15),
                    ),
                  ),
                  child: isLoading == true
                      ? const CircularProgressIndicator()
                      : const Text("Login"),
                ),
                const SizedBox(height: 10),
                if (state.resMessage != null)
                  Text(
                    state.resMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  final TextInputType? keyboardTextType;
  final String? textHint;
  final TextEditingController? controller;
  const TextFieldWidget({
    super.key,
    this.keyboardTextType,
    this.textHint,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardTextType,
      decoration: InputDecoration(
        hintText: textHint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
