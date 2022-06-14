// ignore_for_file: unused_import, prefer_const_constructors, implementation_imports

import 'dart:io';


import 'package:first_app/layout/news/cubit/states.dart';
import 'package:first_app/layout/news/newsLayout.dart';


import 'package:first_app/network/locale/cashHelper.dart';
import 'package:first_app/network/remote/dioHelper.dart';
import 'package:first_app/shared/blocObserver.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/styles/thems.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/services/system_chrome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:intl/intl.dart';

import 'layout/news/cubit/cubit.dart';

import 'network/locale/httpHelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  HttpOverrides.global = MyHttpOverrides();
  await DioHelper.init();

  await CashHelper.init();


  bool? isDark = CashHelper.getData(key: 'isDark');

  Widget? startWidget;
  

  

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
  );
  runApp(MyApp(
    isDark: isDark,
    startScreen: NewsLayout(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({this.isDark, this.startScreen});

  final bool? isDark;
  final Widget? startScreen;

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Color.fromRGBO(0, 0, 0, 0));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..changTheme(fromshared: isDark),
        ),
       
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            themeMode: NewsCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            darkTheme: darkTheme,
            theme: lightTheme,
            
            debugShowCheckedModeBanner: false,
            home: startScreen,
          );
        },
      ),
    );
  }
}
