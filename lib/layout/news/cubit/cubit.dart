import 'package:bloc/bloc.dart';
import 'package:first_app/layout/news/cubit/states.dart';
import 'package:first_app/modules/news_app/business/business.dart';
import 'package:first_app/modules/news_app/scince/scince.dart';
import 'package:first_app/modules/news_app/sport/sport.dart';

import 'package:first_app/network/locale/cashHelper.dart';
import 'package:first_app/network/remote/dioHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitState());
  static NewsCubit get(context) => BlocProvider.of(context);
  /////////////////////////////////////

  int bottomNavIndex = 0;
  bool isDark = false;
  Color? containerColor = Colors.blueGrey[100];
  ThemeMode themeMode = ThemeMode.light;
  List<Widget> screens = [
    const Business(),
    const Sports(),
    const Scince(),
    Container()
  ];
  List<dynamic> businessNews = [];
  List<dynamic> sportsNews = [];
  List<dynamic> scinceNews = [];
  List<dynamic> searchNews = [];
  void changNavBar() {
    emit(NewsChangeBottmNavBar());
  }

  void getBusiness() {
    emit(NewsGetBusinessloading());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'language': 'ar',
      'category': 'business',
      'apiKey': '7212653e13154c6396a34fbbd0416c5b'
    }).then((value) {
      businessNews = value.data['articles'];
      emit(NewsGetBusiness());
      if (kDebugMode) {
        print(businessNews.length);
      }
    }).catchError((error) {
      if (kDebugMode) {
        emit(NewsGetBusinessError(error.toString()));
        print(error.toString());
      }
    });
  }

  void getSports() {
    emit(NewsGetSportsloading());
    if (sportsNews.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'language': 'ar',
        'category': 'sports',
        'apiKey': '7212653e13154c6396a34fbbd0416c5b'
      }).then((value) {
        sportsNews = value.data['articles'];
        emit(NewsGetSports());
        if (kDebugMode) {
          print(sportsNews.length);
        }
      }).catchError((error) {
        if (kDebugMode) {
          emit(NewsGetSportsError(error.toString()));
          print(error.toString());
        }
      });
    }
  }

  void getScince() {
    emit(NewsGetScinceloading());
    if (scinceNews.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'language': 'ar',
        'category': 'science',
        'apiKey': '7212653e13154c6396a34fbbd0416c5b'
      }).then((value) {
        scinceNews = value.data['articles'];
        emit(NewsGetScince());
        if (kDebugMode) {
          print(scinceNews.length);
        }
      }).catchError((error) {
        if (kDebugMode) {
          emit(NewsGetScinceError(error.toString()));
          print(error.toString());
        }
      });
    }
  }

  void getSearch(value) {
    searchNews = [];
    emit(NewsGetSearchloading());
    if (searchNews.isEmpty) {
      DioHelper.getData(url: 'v2/everything', query: {
        'language': 'ar',
        'q': value.toString(),
        'apiKey': '7212653e13154c6396a34fbbd0416c5b'
      }).then((value) {
        searchNews = value.data['articles'];
        emit(NewsGetSearch());
        if (kDebugMode) {
          print(searchNews.length);
        }
      }).catchError((error) {
        if (kDebugMode) {
          emit(NewsGetSearchError(error.toString()));
          print(error.toString());
        }
      });
    }
  }

  void changTheme({bool? fromshared}) {
    if (fromshared != null) {
      isDark = fromshared;

      emit(NewsChangTheme());
    } else {
      isDark = !isDark;
      CashHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(NewsChangTheme());
      });
    }
  }
}
