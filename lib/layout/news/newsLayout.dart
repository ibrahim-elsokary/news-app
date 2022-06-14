// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:first_app/layout/news/cubit/cubit.dart';
import 'package:first_app/layout/news/cubit/states.dart';
import 'package:first_app/modules/news_app/newsSearch/newsSearch.dart';

import 'package:first_app/network/remote/dioHelper.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: IconButton(
                    onPressed: () {
                      cubit.changTheme();
                      if (kDebugMode) {
                        print(cubit.themeMode.toString());
                      }
                    },
                    icon: Icon(
                      Icons.brightness_4_sharp,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: IconButton(
                    onPressed: () {
                      navigateTo(context, NewsSearch());
                    },
                    icon: Icon(
                      Icons.search_rounded,
                    )),
              )
            ],
            title: Text('NEWS APP'),
          ),
          bottomNavigationBar: bootmNavBar(context),
          body: cubit.screens[cubit.bottomNavIndex],
        );
      },
    );
  }
}

String apiKey = 'e8b6058e0fa54e9d8169469cae0f5173';
var scaffoldKey = GlobalKey<ScaffoldState>();
Widget bootmNavBar(context) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    items: [
      BottomNavigationBarItem(icon: Icon(Icons.attach_money_sharp), label: ''),
      BottomNavigationBarItem(
          icon: Icon(Icons.sports_basketball_rounded), label: ''),
      BottomNavigationBarItem(icon: Icon(Icons.science_rounded), label: ''),
    ],
    onTap: (value) {
      NewsCubit.get(context).bottomNavIndex = value;
      NewsCubit.get(context).changNavBar();
      if (value == 0) {
        NewsCubit.get(context).getBusiness();
      } else if (value == 1) {
        NewsCubit.get(context).getSports();
      } else if (value == 2) {
        NewsCubit.get(context).getScince();
      }
    },
    currentIndex: NewsCubit.get(context).bottomNavIndex,
  );
}
