abstract class NewsStates {}

class InitialState extends NewsStates {}

class BottomNavState extends NewsStates {}

class GetHomeSuccessState extends NewsStates {}
class GetHomeErrorState extends NewsStates {
  final String error;
  GetHomeErrorState(this.error);
}
class HomeLoadingState extends NewsStates {}

class GetSearchSuccessState extends NewsStates {}

class GetSearchErrorState extends NewsStates {
  final String error;
  GetSearchErrorState(this.error);
}

class SearchLoadingState extends NewsStates {}

// class SearchInitState extends NewsStates{}
//////////
class GetNewsLoadingState extends NewsStates {}

class GetNewsSuccessState extends NewsStates {
  final List<dynamic> result;

  GetNewsSuccessState({required this.result});
}

class GetNewsErrorState extends NewsStates {
  final String message;
  GetNewsErrorState({required this.message});
}
