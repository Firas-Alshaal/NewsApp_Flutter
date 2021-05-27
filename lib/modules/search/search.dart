import 'package:ahmad_mansour/Components/component.dart';
import 'package:ahmad_mansour/Layout/NewsApp/Cubit/cubit.dart';
import 'package:ahmad_mansour/Layout/NewsApp/Cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewState>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.deepOrange),
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'search must not be empty';
                      }
                      return null;
                    },
                    onChange: (String value) {
                      NewsCubit.get(context).getSearch(value);
                    },
                    label: 'Search',
                    prefix: Icons.search),
              ),
              Expanded(child: articleBuilder(list, context,isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
