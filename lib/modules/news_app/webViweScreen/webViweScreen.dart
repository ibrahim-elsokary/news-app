import 'package:first_app/layout/news/cubit/cubit.dart';
import 'package:first_app/layout/news/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViweScreen extends StatelessWidget {
  late final String url;
  WebViweScreen(this.url);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: WebView(
            initialUrl: url,
          ),
        );
      },
    );
  }
}
