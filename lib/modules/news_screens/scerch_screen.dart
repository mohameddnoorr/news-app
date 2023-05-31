import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/news_cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';

class SearchNews extends StatelessWidget {
  SearchNews({Key? key}) : super(key: key);
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  style: const TextStyle(color: Colors.grey),
                  keyboardType: TextInputType.text,
                  controller: searchController,
                  onChanged: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search_rounded),
                  ),
                ),
              ),
              Expanded(
                child: ConditionalBuilder(
                  condition: NewsCubit.get(context).search.isNotEmpty,
                  builder: (context) => ListView.separated(
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return articleItem(
                        NewsCubit.get(context).search[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return myLine();
                    },
                    itemCount: NewsCubit.get(context).search.length,
                  ),
                  fallback: (context) {
                    if (state is SearchLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return const Center(child: Icon(Icons.search,size:200,color:Colors.grey));
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
