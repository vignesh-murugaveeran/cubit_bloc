import 'package:bloc_learning/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
* Title: BlocBuilder, BlocListener, and BlocConsumer
* BlocBuilder -> similar to the Obx() in getx.
* BlocListener -> based on state changes, it will do the action.
* BlocConsumer -> BlocBuilder + BlocListener.
*/
void main() {
  //create: (context) => CounterCubit() ---> Make a CounterCubit available to this widget tree(MyApp()).
  runApp(
    BlocProvider(create: (context) => CounterCubit(), child: const MyApp()),
  );
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
      home: const MyHomePage(title: 'BLoC'),
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
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BlocListener<CounterCubit, int>(
        listener: (context, state) {
          if (state == 5) {
            //we can't put the snackbar inside the BlocBuilder.
            //BlocBuilder only rebuild the widget.
            //BlocListener -> based state changes, it will do the action
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('State is 5!')));
          }
        },
        child: Center(
          child: BlocBuilder<CounterCubit, int>(
            builder: ((context, state) {
              /**
               *  BlocBuilder<CounterCubit, int>(
                   builder: (context, count) {
                      return Text('$count');
                   },
                  )
               * It basically says:
                 Listen to CounterCubit and rebuild this widget whenever its state changes.
               */
              return Text(
                '$state',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            }),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              /**
               *  context.read<CounterCubit>().increment();
                  This means:
                  Find the CounterCubit provided above me and call increment().
               */
              context.read<CounterCubit>().reset();
            },
            tooltip: 'Reset',
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterCubit>().increment();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterCubit>().decrement();
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
