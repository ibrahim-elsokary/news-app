// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:first_app/layout/news/cubit/cubit.dart';
import 'package:first_app/layout/news/cubit/states.dart';
import 'package:first_app/shared/components/components.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    child: defaultFormField(
                      context,
                      controller: searchController,
                      type: TextInputType.text,
                      prefixcIcon: const Icon(Icons.search_rounded),
                      hint: 'SEARCH HERE',
                      validator: (String? val) {
                        if (val!.isEmpty) {
                          return 'SEARCH IS EMPTY';
                        }
                      },
                      onFaildSubmitted: (value) {
                        NewsCubit.get(context).getSearch(value);
                      },
                    ),
                  ),
                ),
                Expanded(
                    child: ConditionalBuilder(
                  condition: state != NewsGetSearchloading,
                  builder: (context) => articalBuilder(
                      context: context,
                      list: NewsCubit.get(context).searchNews),
                  fallback: (context) =>
                      const Center(child: CircularProgressIndicator()),
                ))
              ],
            ),
          );
        });
  }
}

var searchController = TextEditingController();

Widget search(context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          child: defaultFormField(
            context,
            controller: searchController,
            type: TextInputType.text,
            prefixcIcon: const Icon(Icons.search_rounded),
            hint: 'SEARCH HERE',
            validator: (val) {
              if (val!.isEmpty) {
                return 'SEARCH IS EMPTY';
              }
            },
            onChanged: (value) {
              if (value != null) {
                NewsCubit.get(context).getSearch(value);
              }
            },
          ),
        ),
      ),
      Expanded(
          child: articalBuilder(
              context: context, list: NewsCubit.get(context).searchNews))
    ],
  );
}
