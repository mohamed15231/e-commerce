import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealapp/layout/cubit/cubit.dart';
import 'package:mealapp/modules/login/cubit/cubit.dart';
import 'package:mealapp/modules/login/cubit/state.dart';
import 'package:mealapp/modules/register/register.dart';
import 'package:mealapp/shared/network/cachehelper.dart';
import '../../layout/shop_app_layout/shoplayout.dart';
import '../../shared/components/components/components.dart';
import '../../shared/components/constant/constant.dart';

class LogIn extends StatelessWidget {
   LogIn({Key? key}) : super(key: key);
    var emailLoginController=TextEditingController();
    var passwordRegisterController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => LogInShopCubit(),
        child: BlocConsumer<LogInShopCubit, LoginShopStates>(
          listener: (context, state) {
            if (state is SuccessLoginState) {

              if (state.loginModel.status == true) {
                token=state.loginModel.data!.token! ;
                CacheHelper.setData(key: 'token', value: state.loginModel.data!.token);
                navigateAndReplace(
                  context: context,
                  page:  const ShopLayOut(),
                );
              } else {
                toastShow(
                  text: "${state.loginModel.message}",
                  state: ToastState.ERROR,
                );
              }
            }
          },
          builder: (context, state) => Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formLogInKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "LOGIN",
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "login now to browse our hot offers",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),

                      //Email Address
                      defaultTextForm(
                          typeKeyboard: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Email must be not empty";
                            }
                            return null;
                          },
                          controller: emailLoginController,
                          preIcon: const Icon(Icons.email_outlined),
                          labelText: const Text("Email Address")),
                      const SizedBox(
                        height: 15.0,
                      ),

                      //Password
                      defaultTextForm(
                        submit: (value) {
                          if (formLogInKey.currentState!.validate()) {
                            LogInShopCubit.get(context).userLogIn(
                              email: emailLoginController.text,
                              password: passwordRegisterController.text,
                            );
                          }
                          return null;
                        },
                        typeKeyboard: TextInputType.visiblePassword,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return "Password must be not empty";
                          }
                          return null;
                        },
                        controller: passwordRegisterController,
                        preIcon: const Icon(Icons.lock_outlined),
                        labelText: const Text("Password"),
                        isPassword: LogInShopCubit.get(context).isPass,
                        suffixIcon: IconButton(
                          onPressed:
                              LogInShopCubit.get(context).changeEyeInPassword,
                          icon: Icon(LogInShopCubit.get(context).icon),
                        ),
                      ),

                      const SizedBox(
                        height: 20.0,
                      ),

                      //ElevatedButton
                      ConditionalBuilderRec(
                        condition: state is! LoadingLoginState,
                        builder: (BuildContext context) =>
                            defaultElevatedButton(
                          text: 'login',
                          pressed: () {
                            if (formLogInKey.currentState!.validate()) {
                              LogInShopCubit.get(context).userLogIn(
                                email: emailLoginController.text,
                                password: passwordRegisterController.text,
                              );
                            }
                          },
                        ),
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),

                      //Register
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account ?",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              navigateAndReplace(
                                context: context,
                                page:  Register(),
                              );
                            },
                            child: Text(
                              "Register".toUpperCase(),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
