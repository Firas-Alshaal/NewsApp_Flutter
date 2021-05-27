import 'package:ahmad_mansour/Components/component.dart';
import 'package:ahmad_mansour/Counter/Cubit/cubit.dart';
import 'package:ahmad_mansour/Counter/Cubit/status.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TasksDataBase extends StatelessWidget {
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (BuildContext context, AppState state) {
          if (state is AppInsertDataBaseState) {
            Navigator.pop(context);
            titleController.text = '';
            timeController.text = '';
            dateController.text = '';
          }
        },
        builder: (BuildContext context, AppState state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDataBaseLoadingState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState.validate()) {
                    cubit.insertDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                  }
                } else {
                  scaffoldKey.currentState
                      .showBottomSheet(
                          (context) => Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(20.0),
                                child: Form(
                                  key: formKey,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        defaultFormField(
                                          controller: titleController,
                                          type: TextInputType.text,
                                          onTap: () {},
                                          validate: (String value) {
                                            if (value.isEmpty) {
                                              return 'title must not be empty';
                                            }
                                            return null;
                                          },
                                          label: 'Task Title',
                                          prefix: Icons.title,
                                        ),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        defaultFormField(
                                          controller: timeController,
                                          type: TextInputType.datetime,
                                          onTap: () {
                                            showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now())
                                                .then((value) {
                                              timeController.text = value
                                                  .format(context)
                                                  .toString();
                                            });
                                          },
                                          validate: (String value) {
                                            if (value.isEmpty) {
                                              return 'time must not be empty';
                                            }
                                            return null;
                                          },
                                          label: 'Task Time',
                                          prefix: Icons.watch_later_outlined,
                                        ),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        defaultFormField(
                                          controller: dateController,
                                          type: TextInputType.datetime,
                                          onTap: () {
                                            showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate:
                                                  DateTime.parse('2021-12-20'),
                                            ).then((value) {
                                              dateController.text =
                                                  DateFormat.yMMMd()
                                                      .format(value);
                                              print(DateFormat.yMMMd()
                                                  .format(value));
                                            });
                                          },
                                          validate: (String value) {
                                            if (value.isEmpty) {
                                              return 'Date must not be empty';
                                            }
                                            return null;
                                          },
                                          label: 'Task Date',
                                          prefix: Icons.calendar_today,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          elevation: 20.0)
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                        isShow: false, icon: Icons.edit);
                  });
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: 'Archive'),
              ],
              currentIndex: cubit.currentIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                cubit.changeState(index);
              },
            ),
          );
        },
      ),
    );
  }
}
