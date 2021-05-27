// 1- create database
// 2- create tables
// 3- open database
// 4- insert to database
// 5- get from database
// 6- update database
// 7- delete from database

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'Components/constants.dart';

Database database;

void createDatabase() async {
  database =
      await openDatabase('todo.db', version: 1, onCreate: (database, version) {
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
//    getDataFromDatabase(database).then((value) {
//      setState(() {
//        tasks = value;
//        print(tasks);
//      });
//    });
    print('open database');
  });
}

Future insertDatabase(
    {@required String title,
    @required String time,
    @required String date}) async {
  return await database.transaction((txn) {
    txn
        .rawInsert(
            'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","first")')
        .then((value) {
      print("$value insert successfully");
    }).catchError((error) {
      print('error when inserting table: ${error.toString()}');
    });
    return null;
  });
}

Future<List<Map>> getDataFromDatabase(database) async {
  return tasks = await database.rawQuery('SELECT * FROM tasks');
}
