import 'package:ahmad_mansour/Counter/Cubit/status.dart';
import 'package:ahmad_mansour/Screen_Task/archieveTask.dart';
import 'package:ahmad_mansour/Screen_Task/doneTask.dart';
import 'package:ahmad_mansour/Screen_Task/newTask.dart';
import 'package:ahmad_mansour/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitializeState());

  static CounterCubit get(context) => BlocProvider.of(context);

  int counter = 1;

  void minus() {
    counter--;
    emit(CounterMinusState());
  }

  void plus() {
    counter++;
    emit(CounterPlusState());
  }
}

// BOTTOM NAVIGATION BAR APP

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitializeState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [NewTask(), DoneTask(), ArchivedTask()];
  List<String> titles = ['New Task', 'Done Task', 'Archived Task'];

  void changeState(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  // DataBase
  Database database;
  List<Map> newTasks = [];
  List<Map> archiveTasks = [];
  List<Map> doneTasks = [];

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    @required bool isShow,
    @required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  void createDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      print('create database');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT ,date TEXT ,time TEXT , status TEXT)')
          .then((value) {
        print("table created");
      }).catchError((error) {
        print('error when creating table: ${error.toString()}');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);
      print('open database');
    }).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });
  }

  Future insertDatabase(
      {@required String title,
      @required String time,
      @required String date}) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","first")')
          .then((value) {
        print("$value insert successfully");
        emit(AppInsertDataBaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('error when inserting table: ${error.toString()}');
      });
      return null;
    });
  }

  void updateData({
    @required String status,
    @required int id,
  }) async {
    await database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', '$id']).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDataBaseState());
    });
  }

  void deleteData({
    @required int id,
  }) async {
    await database
        .rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDataBaseState());
    });
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];

    emit(AppGetDataBaseLoadingState());

    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newTasks.add(element);
        else if (element['status'] == 'done')
          doneTasks.add(element);
        else
          archiveTasks.add(element);
      });

      emit(AppGetDataBaseState());
    });
  }

  bool isDark = false;

  void changeModeApp({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
