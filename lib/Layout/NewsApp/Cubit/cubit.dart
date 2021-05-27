import 'package:ahmad_mansour/Layout/NewsApp/Cubit/states.dart';
import 'package:ahmad_mansour/modules/business/business_screen.dart';
import 'package:ahmad_mansour/modules/science/science_screen.dart';
import 'package:ahmad_mansour/modules/sports/sport_screen.dart';
import 'package:ahmad_mansour/modules/technology/technology.dart';
import 'package:ahmad_mansour/network/remote/dio_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewState> {
  NewsCubit() : super(NewsInitializeState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    BottomNavigationBarItem(
        icon: Icon(Icons.wifi_outlined), label: 'Technology'),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
    TechnologyScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    /* if (currentIndex == 0) {
      getBusiness();
      emit(NewsBottomBarState());
    } */
    if (currentIndex == 1) {
      getSport();
      //emit(NewsBottomBarState());
    } else if (currentIndex == 2) {
      getScience();
      //emit(NewsBottomBarState());
    } else if (currentIndex == 3) {
      getTechnology();
      //emit(NewsBottomBarState());
    }
    emit(NewsBottomBarState());
  }

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> technology = [];
  List<dynamic> search = [];

  void getBusiness() {
    emit(NewsBusinessLoadingState());
    DioHelper.getData(url: '/v2/top-headlines', query: {
      'country': 'us',
      'category': 'business',
      'apiKey': 'e7c9d190634748ad872cafcd97ab21b9'
    }).then((value) {
      business = value.data['articles'];
      emit(NewsBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsBusinessErrorState(error.toString()));
    });
  }

  void getSport() {
    if (sports.length == 0) {
      emit(NewsSportLoadingState());
      DioHelper.getData(url: '/v2/top-headlines', query: {
        'country': 'us',
        'category': 'sport',
        'apiKey': 'e7c9d190634748ad872cafcd97ab21b9'
        //65f7f556ec76449fa7dc7c0069f040ca
      }).then((value) {
        sports = value.data['articles'];
        emit(NewsSportSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsSportErrorState(error.toString()));
      });
    } else {
      emit(NewsSportSuccessState());
    }
  }

  void getScience() {
    emit(NewsScienceLoadingState());

    if (science.length == 0) {
      DioHelper.getData(
        url: '/v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'science',
          'apiKey': 'e7c9d190634748ad872cafcd97ab21b9'
          //'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        },
      ).then((value) {
        science = value.data['articles'];
        emit(NewsScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsScienceSuccessState());
    }
  }

  void getTechnology() {
    emit(NewsTechnologyLoadingState());
    DioHelper.getData(url: '/v2/top-headlines', query: {
      'country': 'us',
      'category': 'technology',
      'apiKey': 'e7c9d190634748ad872cafcd97ab21b9'
    }).then((value) {
      technology = value.data['articles'];
      emit(NewsTechnologySuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsTechnologyErrorState(error.toString()));
    });
  }

  void getSearch(String value) {
    emit(NewsTechnologyLoadingState());

    DioHelper.getData(url: '/v2/everything', query: {
      'q': '$value',
      'apiKey': 'e7c9d190634748ad872cafcd97ab21b9'
    }).then((value) {
      search = value.data['articles'];
      emit(NewsSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsSearchErrorState(error.toString()));
    });
  }
}
