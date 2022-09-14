import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealapp/modules/login/cubit/state.dart';
import 'package:mealapp/shared/network/dio.dart';

import '../../../models/login_shop_model.dart';
import '../../../shared/endpoints.dart';

class LogInShopCubit extends Cubit<LoginShopStates> {
  LogInShopCubit() : super(InitialLoginState());

  static LogInShopCubit get(context) => BlocProvider.of(context);


  LogInModel? loginModel;
  void userLogIn({
    required String email,
    required String password,
  }) {
    emit(LoadingLoginState());
    DioHelper.postData(
      url: logIn,
      data: {
        'email': email,
        "password": password,
      },
    ).then((value) {
      loginModel=LogInModel.jsonData(value.data);
      emit(SuccessLoginState(loginModel!));
    }).catchError((error) {
      print(error);
      emit(ErrorLoginState(error.toString()));
    });
  }

  bool isPass = true;
  IconData icon = Icons.visibility_outlined;

  void changeEyeInPassword() {
    isPass = !isPass;
    icon = isPass ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeIcon());
  }
}
