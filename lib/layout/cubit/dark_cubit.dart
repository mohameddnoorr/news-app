import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/layout/cubit/states_dark.dart';
import '../../shared/network/local/cache_helper.dart';

class DarkCubit extends Cubit<DarkStates>{
  DarkCubit() : super(InitialState());
  static DarkCubit get(context) => BlocProvider.of(context);

  bool isDark=false;
  void modeChange({bool? shared})
  {
    if(shared != null) {
      isDark = shared  ;
      emit(ChangeModeState());
    }else {
      isDark =!isDark;
      CacheHelper.putData(key: 'isDark', value:isDark ).then((value){
        emit(ChangeModeState());
      });
    }


  }
}