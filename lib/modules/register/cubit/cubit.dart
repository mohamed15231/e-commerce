import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealapp/modules/login/cubit/state.dart';
import 'package:mealapp/modules/register/cubit/state.dart';
import 'package:mealapp/shared/network/dio.dart';

import '../../../models/login_shop_model.dart';
import '../../../shared/endpoints.dart';

class RegisterShopCubit extends Cubit<RegisterShopStates> {
  RegisterShopCubit() : super(InitialRegisterState());

  static RegisterShopCubit get(context) => BlocProvider.of(context);


  LogInModel? loginModel;
  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(LoadingRegisterState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        "name": name,
        'email': email,
        "password": password,
        'phone': phone,


      },
    ).then((value) {
      print("value ${value.data}");
      loginModel=LogInModel.jsonData(value.data);
      print(loginModel?.data!.token);
      emit(SuccessRegisterState(loginModel!));
    }).catchError((error) {
      print(error);
      emit(ErrorRegisterState(error.toString()));
    });
  }

  bool isPass = true;
  IconData icon = Icons.visibility_outlined;

  void changeEyeInPassword() {
    isPass = !isPass;
    icon = isPass ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeRegisterIcon());
  }
}
