import 'package:ahmad_mansour/Components/component.dart';
import 'package:ahmad_mansour/Counter/Cubit/cubit.dart';
import 'package:ahmad_mansour/Layout/NewsApp/Cubit/cubit.dart';
import 'package:ahmad_mansour/Layout/NewsApp/Cubit/states.dart';
import 'package:ahmad_mansour/modules/search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewState>(
      listener: (context, state) => {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  }),
              IconButton(
                  icon: Icon(Icons.brightness_4_outlined),
                  onPressed: () {
                    AppCubit.get(context).changeModeApp();
                  }),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.deepOrange,
            elevation: 20.0,
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItems,
            onTap: (int index) {
              cubit.changeBottomNavBar(index);
            },
          ),
        );
      },
    );
  }
}

// Api :35dddf1d2ce44c0aa51f33af079936b2
// nameEmail : risehex762@troikos.com
// name: Rechard
