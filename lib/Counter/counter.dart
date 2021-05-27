import 'package:ahmad_mansour/Counter/Cubit/cubit.dart';
import 'package:ahmad_mansour/Counter/Cubit/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Counter'),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).minus();
                      },
                      child: Text('Minus')),
                  Text('${CounterCubit.get(context).counter}'),
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).plus();
                      },
                      child: Text('Plus'))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
