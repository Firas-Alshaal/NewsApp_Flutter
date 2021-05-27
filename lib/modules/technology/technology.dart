import 'package:ahmad_mansour/Components/component.dart';
import 'package:ahmad_mansour/Layout/NewsApp/Cubit/cubit.dart';
import 'package:ahmad_mansour/Layout/NewsApp/Cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TechnologyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewState>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = NewsCubit.get(context).technology;
          return articleBuilder(list, context);
        });
  }
}
