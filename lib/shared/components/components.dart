// ignore_for_file: unused_local_variable

import 'package:first_app/layout/news/cubit/cubit.dart';

import 'package:first_app/modules/news_app/webViweScreen/webViweScreen.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';

Widget defaultButton({
  required context,
  double wid = double.infinity,
  double r = 5.0,
  required String text,
  bool isUpper = true,
  Color bgClolor = Colors.blue,
  required void Function()? onPressed,
}) =>
    Container(
      width: wid,
      decoration: BoxDecoration(
        color: bgClolor,
        borderRadius: BorderRadius.circular(
          r,
        ),
      ),
      child: FlatButton(
        onPressed: onPressed,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );

Widget defaultFormField(
  context, {
  required controller,
  hint = '',
  required type,
  Function? onType,
  isPassword = false,
  Icon? prefixcIcon,
  IconButton? suffixIcon,
  Function(dynamic value)? onFaildSubmitted,
  VoidCallback? onTap,
  Function(String)? onChanged,
  String? Function(String? val)? validator,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          5.0,
        ),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      child: TextFormField(
        validator: validator,
        onFieldSubmitted: onFaildSubmitted,
        onTap: onTap,
        onChanged: onChanged,
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixcIcon,
          hintText: hint,
          errorStyle: Theme.of(context).textTheme.bodyText1,
          helperStyle: Theme.of(context).textTheme.bodyText1,
          floatingLabelStyle: Theme.of(context).textTheme.bodyText1,
          labelStyle: Theme.of(context).textTheme.bodyText1,
          counterStyle: Theme.of(context).textTheme.bodyText1,
          border: InputBorder.none,
        ),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinsh(context, widget) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ), (value) {
      return false;
    });

Widget buildSeparator() => Container(
      height: 1.0,
      width: double.infinity,
      color: Colors.grey[300],
    );



Widget news(context,
    {required title, required date, required imageUrl, required String url}) {
  Color color;
  return InkWell(
    onTap: () {
      navigateTo(context, WebViweScreen(url));
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: NewsCubit.get(context).isDark
                ? Colors.blueGrey[900]
                : Colors.blueGrey[100]),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                clipBehavior: Clip.antiAlias,
                height: 110,
                width: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.network(
                  '$imageUrl',
                  fit: BoxFit.cover,
                  scale: 0.5,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.network_wifi);
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$title ',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text('$date'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget articalBuilder({required context, required list}) {
  return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return news(context,
            url: list[index]['url'],
            imageUrl: list[index]['urlToImage'],
            title: list[index]['title'],
            date: list[index]['publishedAt']);
      },
      separatorBuilder: (context, index) => Container(),
      itemCount: list.length);
}

void showToast({required String msg, required state}) {
  Fluttertoast.showToast(
      msg: msg,
      backgroundColor: toastColor(state),
      fontSize: 14,
      textColor: Colors.white,
      timeInSecForIosWeb: 5,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG);
}

// ignore: constant_identifier_names
enum ToastState { ERROR, SUCCESS, WARNING }
Color toastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.orange;
      break;
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
  }

  return color;
}
