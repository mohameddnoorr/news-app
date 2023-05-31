import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/shared/network/local/cache_helper.dart';
import 'package:news_application/shared/network/remote/dio_helper.dart';
import 'layout/cubit/dark_cubit.dart';
import 'layout/cubit/news_cubit.dart';
import 'layout/cubit/states_dark.dart';
import 'layout/news_layout/news_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  isDark ??= false;
  runApp(MyApp(isDark: isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  const MyApp({required this.isDark, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                DarkCubit()..modeChange(shared: isDark)),
        BlocProvider(
          create: (BuildContext context) => NewsCubit()..getHome(),
        ),
      ],
      child: BlocConsumer<DarkCubit, DarkStates>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(
                labelStyle: TextStyle(color: Colors.deepOrange),
                prefixIconColor: Colors.deepOrange,
                focusedBorder: OutlineInputBorder(
                  
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                border: OutlineInputBorder(),
              ),
              primarySwatch: Colors.deepOrange,
              appBarTheme: const AppBarTheme(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                elevation: 0.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarColor: Colors.white,
                ),
                actionsIconTheme: IconThemeData(
                  color: Colors.grey,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              scaffoldBackgroundColor: Colors.white,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey),
            ),
            darkTheme: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(

                labelStyle: TextStyle(color: Colors.deepOrange),
                prefixIconColor: Colors.deepOrange,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
                border: OutlineInputBorder(),
              ),
              primarySwatch: Colors.deepOrange,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.black,
                elevation: 0.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.deepOrange,
                ),
                actionsIconTheme: IconThemeData(
                  color: Colors.deepOrange,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              scaffoldBackgroundColor: Colors.black,
              textTheme: const TextTheme(
                bodyText2: TextStyle(
                  color: Colors.grey,
                ),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.black,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
              ),
            ),
            themeMode: DarkCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const NewsLayout(),
          );
        },
      ),
    );
  }
}
st