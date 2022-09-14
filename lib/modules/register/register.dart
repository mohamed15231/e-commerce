import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealapp/modules/login/log%20in.dart';
import 'package:mealapp/modules/register/cubit/cubit.dart';
import 'package:mealapp/modules/register/cubit/state.dart';

import '../../layout/shop_app_layout/shoplayout.dart';
import '../../shared/components/components/components.dart';
import '../../shared/components/constant/constant.dart';
import '../../shared/network/cachehelper.dart';

class Register extends StatelessWidget {
   Register({Key? key}) : super(key: key);

  var emailRegisterController=TextEditingController();
  var passwordRegisterController=TextEditingController();
  var phoneRegisterController=TextEditingController();
  var nameRegisterController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => RegisterShopCubit(),
        child: BlocConsumer<RegisterShopCubit, RegisterShopStates>(
          listener: (context, state) {

            if (RegisterShopCubit.get(context).loginModel!=null) {
              if (RegisterShopCubit.get(context).loginModel!.status == true) {
                token = RegisterShopCubit.get(context).loginModel!.data!.token!;
                CacheHelper.setData(
                    key: 'token', value: RegisterShopCubit.get(context).loginModel!.data!.token);
                navigateAndReplace(
                  context: context,
                  page:  const ShopLayOut(),
                );
              } else {
                toastShow(
                  text: "${RegisterShopCubit.get(context).loginModel!.message}",
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
                  key: formRegisterKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "REGISTER",
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "Register now to browse our hot offers",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),

                      //Name
                      defaultTextForm(
                        typeKeyboard: TextInputType.name,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return "Name must be not empty";
                          }
                          return null;
                        },
                        controller: nameRegisterController,
                        preIcon: const Icon(Icons.person),
                        labelText: const Text("User Name"),
                      ),

                      const SizedBox(
                        height: 20.0,
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
                        controller: emailRegisterController,
                        preIcon: const Icon(Icons.email_outlined),
                        labelText: const Text("Email Address"),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),

                      //Password
                      defaultTextForm(
                        submit: (value) {
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
                        isPassword: RegisterShopCubit.get(context).isPass,
                        suffixIcon: IconButton(
                          onPressed: RegisterShopCubit.get(context)
                              .changeEyeInPassword,
                          icon: Icon(RegisterShopCubit.get(context).icon),
                        ),
                      ),

                      const SizedBox(
                        height: 15.0,
                      ),

                      //Phone
                      defaultTextForm(
                        typeKeyboard: TextInputType.phone,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return "Phone must be not empty";
                          }
                          return null;
                        },
                        controller: phoneRegisterController,
                        preIcon: const Icon(Icons.phone),
                        labelText: const Text("Phone Number"),
                      ),

                      const SizedBox(
                        height: 20.0,
                      ),

                      //ElevatedButton
                      ConditionalBuilderRec(
                        condition: state is! LoadingRegisterState,
                        builder: (BuildContext context) =>
                            defaultElevatedButton(
                          text: 'register',
                          pressed: () {
                            print(emailRegisterController.text);
                            print(passwordRegisterController.text);
                            print(nameRegisterController.text);
                            print(phoneRegisterController.text);
                            if (formRegisterKey.currentState!.validate()) {
                              RegisterShopCubit.get(context).userRegister(
                                email: emailRegisterController.text,
                                password: passwordRegisterController.text,
                                name: nameRegisterController.text,
                                phone: phoneRegisterController.text,
                              );
                            }
                            },
                        ),



                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Do have an account ?",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              navigateAndReplace(
                                context: context,
                                page:  LogIn(),
                              );
                            },
                            child: Text(
                              "Login".toUpperCase(),
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
