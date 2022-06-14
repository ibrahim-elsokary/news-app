// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first_app/layout/news/cubit/cubit.dart';
import 'package:first_app/layout/news/cubit/states.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Business extends StatelessWidget {
  const Business({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! NewsGetBusinessloading,
          builder: (context) => articalBuilder(
              context: context, list: NewsCubit.get(context).businessNews),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
