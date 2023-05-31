import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/dark_cubit.dart';
import '../cubit/news_cubit.dart';
import '../cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('News'),
            actions: [
              IconButton(onPressed: () {
                DarkCubit.get(context).modeChange();
              }, icon: const Icon(Icons.dark_mode_rounded)),

            ],
          ),
          body: NewsCubit.get(context).screens[NewsCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: NewsCubit.get(context).currentIndex,

            onTap: (index) {
              NewsCubit.get(context).changeNav(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_rounded,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search_rounded,
                  ),
                  label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu_rounded,
                  ),
                  label: 'Categories'),


            ],

          ),
        );
      },
    );
  }
}
