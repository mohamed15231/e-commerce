import 'package:flutter/material.dart';
import 'package:mealapp/layout/cubit/cubit.dart';
import 'package:mealapp/models/boardingmodel.dart';

import '../../../modules/login/log in.dart';
import '../../network/cachehelper.dart';
import '../components/components.dart';

PageController indicatorController = PageController();
List<BoardingModel> buildPageView = [
  BoardingModel(
    image: "assets/images/shop.jpg",
    screenTitle: "screenTitle",
    ScreenBody: "ScreenBody",
  ),
  BoardingModel(
    image: "assets/images/shop.jpg",
    screenTitle: "screenTitle 2",
    ScreenBody: "ScreenBody 2",
  ),
  BoardingModel(
    image: "assets/images/shop.jpg",
    screenTitle: "screenTitle 3",
    ScreenBody: "ScreenBody 3",
  ),
];
bool isEnd=false;

var formLogInKey=GlobalKey<FormState>();
var formRegisterKey=GlobalKey<FormState>();



void logOut({
  required BuildContext context
}){
  CacheHelper.removeData(key: 'token').then((value) {
    navigateAndReplace(context: context, page:  LogIn());
  });
}

String? token ;