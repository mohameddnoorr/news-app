import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/news_cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';

class NewsListScreen extends StatelessWidget {
  const NewsListScreen({Key? key, required this.category}) : super(key: key);
  final String category;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(listener: (context, state) {
      if (state is GetNewsErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("error happened please try again ."),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red));
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: Text(category)),
        body: Column(children: [
          if (state is GetNewsLoadingState)
            const Expanded(child: Center(child: CircularProgressIndicator())),
          if (state is GetNewsErrorState)
            Expanded(child: Center(child: Text(state.message))),
          if (state is GetNewsSuccessState)
            Expanded(
              child: ListView.separated(
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  return articleItem(state.result[index], context: context);
                },
                separatorBuilder: (context, index) {
                  return myLine();
                },
                itemCount: state.result.length,
              ),
            ),
        ]),
      );
    });
  }
}
