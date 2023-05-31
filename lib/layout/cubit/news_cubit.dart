import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/layout/cubit/states.dart';

import '../../modules/news_screens/category.dart';
import '../../modules/news_screens/home_screen.dart';
import '../../modules/news_screens/scerch_screen.dart';
import '../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(InitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  void changeNav(int index) {
    currentIndex = index;
    emit(BottomNavState());
  }

  List<Widget> screens = [
    const Home(),
    SearchNews(),
    const Category(),
  ];

  void getNews({required String category}) {
    emit(GetNewsLoadingState());
    DioHelper.getData(url: 'v2/top-headlines', quire: {
      'country': 'eg',
      'category': category.toLowerCase(),
      'apiKey': '527bad289a2d4c1cb687c53ea78e94c1',
    }).then((value) {
      emit(GetNewsSuccessState(result: value.data['articles']));
    }).catchError((error) {
      print(error.toString());
      emit(GetNewsErrorState(message: error.toString()));
    });
  }

  List<dynamic> home = [];
  void getHome() {
    emit(HomeLoadingState());
    if (home.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', quire: {
        'country': 'eg',
        'apiKey': '527bad289a2d4c1cb687c53ea78e94c1',
      }).then((value) {
        home = value.data['articles'];
        print(home[0]['title']);
        emit(GetHomeSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(GetHomeErrorState(error));
      });
    } else {
      emit(GetHomeSuccessState());
    }
  }

  List<dynamic> search = [];
  void getSearch(String value) {
    emit(SearchLoadingState());
    DioHelper.getData(url: 'v2/everything', quire: {
      'q': value,
      'apiKey': '527bad289a2d4c1cb687c53ea78e94c1',
    }).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(GetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetSearchErrorState(error));
    });
  }
}
