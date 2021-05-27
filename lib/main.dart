import 'dart:core';

import 'package:ahmad_mansour/Counter/Cubit/cubit.dart';
import 'package:ahmad_mansour/Counter/Cubit/status.dart';
import 'package:ahmad_mansour/network/local/cache_helper.dart';
import 'package:ahmad_mansour/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Components/bloc_observer.dart';
import 'Layout/NewsApp/Cubit/cubit.dart';
import 'Layout/NewsApp/news_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark');

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => NewsCubit()
              ..getBusiness()
              ..getSport()
              ..getScience()
              ..getTechnology()),
        BlocProvider(
          create: (BuildContext context) =>
              AppCubit()..changeModeApp(fromShared: isDark),
        ),
      ],
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: Colors.white,
                backgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                    titleSpacing: 20.0,
                    elevation: 0.0,
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark),
                    color: Colors.white,
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                    iconTheme: IconThemeData(color: Colors.black)),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  elevation: 20.0,
                  unselectedItemColor: Colors.grey,
                  backgroundColor: Colors.white,
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black))),
            darkTheme: ThemeData(
                scaffoldBackgroundColor: HexColor('333739'),
                primarySwatch: Colors.deepOrange,
                appBarTheme: AppBarTheme(
                    titleSpacing: 20.0,
                    elevation: 0.0,
                    backgroundColor: HexColor('333739'),
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: HexColor('333739'),
                        statusBarIconBrightness: Brightness.light),
                    titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                    iconTheme: IconThemeData(color: Colors.white)),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  elevation: 20.0,
                  unselectedItemColor: Colors.grey,
                  backgroundColor: HexColor('333739'),
                ),
                textTheme: TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white))),
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}

/*ahmad_mansour*/