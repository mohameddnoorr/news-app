import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/news_cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        return ConditionalBuilder(
          condition: NewsCubit.get(context).home.isNotEmpty,
          builder: (context) => ListView.separated(
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return articleItem(NewsCubit.get(context).home[index],
                  context: context);
            },
            separatorBuilder: (context, index) {
              return myLine();
            },
            itemCount: NewsCubit.get(context).home.length,
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
