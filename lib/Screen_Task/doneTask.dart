import 'package:ahmad_mansour/Components/component.dart';
import 'package:ahmad_mansour/Counter/Cubit/cubit.dart';
import 'package:ahmad_mansour/Counter/Cubit/status.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoneTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: AppCubit.get(context).doneTasks.length > 0,
      builder: (context) => BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = AppCubit.get(context).doneTasks;
          return ListView.separated(
            itemBuilder: (context, index) =>
                buildTaskItem(tasks[index], context),
            separatorBuilder: (context, index) => Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
            itemCount: tasks.length,
          );
        },
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline,size: 50,),
            Text(
              'No Tasks Yet, Please Add Any One',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
