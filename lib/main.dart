import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealapp/modules/login/log%20in.dart';
import 'package:mealapp/modules/onboarding/on_boarding.dart';
import 'package:mealapp/shared/blocprovider.dart';
import 'package:mealapp/shared/components/constant/constant.dart';
import 'package:mealapp/shared/network/cachehelper.dart';
import 'package:mealapp/shared/network/dio.dart';

import 'layout/shop_app_layout/shoplayout.dart';
import 'style/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  bool? isBoarding = await CacheHelper.getData(key: 'isBoarding');
  token =await CacheHelper.getData(key: 'token');
  Widget widget;
  print(token);
  if(isBoarding != null){
    if(token!=null) {
      widget= const ShopLayOut();
    } else {
      widget= LogIn();
    }

  }else{
    widget=const OnBoarding();
  }

  BlocOverrides.runZoned(
        () {
      runApp( MyApp(isBoarding: isBoarding,startWidget: widget,));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  bool? isBoarding;
  Widget startWidget;

  MyApp({Key? key, required this.isBoarding,required this.startWidget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: startWidget,
      themeMode: ThemeMode.light,
      theme: lightTheme,
    );
  }

}