import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealapp/layout/cubit/states.dart';
import 'package:mealapp/shared/components/constant/constant.dart';
import 'package:mealapp/shared/network/dio.dart';

import '../../layout/cubit/cubit.dart';
import '../../shared/components/components/components.dart';
import '../../shared/endpoints.dart';

class Settings extends StatelessWidget {
   Settings({Key? key}) : super(key: key);
  var  nameController=TextEditingController();

  var emailController=TextEditingController();

  var phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {

        if(state is UpDateSuccessState){
          if(state.profile.status==true){

            toastShow(text: state.profile.message.toString(), state: ToastState.SUCCESS);
            ShopAppCubit.get(context).edit();
            ShopAppCubit.get(context).done();
          }else{
            toastShow(text: state.profile.message.toString(), state: ToastState.ERROR);
            ShopAppCubit.get(context).notDone();
          }
        }
      },
      builder: (BuildContext context, state) {
        var cubit = ShopAppCubit.get(context).profile;

       if(ShopAppCubit.get(context).isDone){
         nameController.text = cubit.data!.name!;
         emailController.text = cubit.data!.email!;
         phoneController.text = cubit.data!.phone! ;
       }
        var formKey = GlobalKey<FormState>();
        return ConditionalBuilderRec(
          condition: !(ShopAppCubit.get(context).profile == null),
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  if(state is UpDateLoadingState)
                    const LinearProgressIndicator(),
                  TextButton(
                    onPressed: ShopAppCubit.get(context).edit,
                    child: const Text(
                      "EDIT",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  ShopAppCubit.get(context).isEdit
                      ? defaultTextForm(
                          typeKeyboard: TextInputType.name,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Name must be not empty";
                            }
                            return null;
                          },
                          controller: nameController,
                          preIcon: const Icon(Icons.person),
                          labelText: const Text("User Name"),
                        )
                      : cardInSitting(
                          prefixIcon: Icons.person,
                          text: "${cubit.data!.name}"),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ShopAppCubit.get(context).isEdit
                      ? defaultTextForm(
                          typeKeyboard: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Email Address must be not empty";
                            }
                            return null;
                          },
                          controller: emailController,
                          preIcon: const Icon(Icons.email),
                          labelText: const Text("Email Address"),
                        )
                      : cardInSitting(
                          prefixIcon: Icons.email,
                          text: "${cubit.data!.email}"),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ShopAppCubit.get(context).isEdit
                      ? defaultTextForm(
                          typeKeyboard: TextInputType.phone,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return "Phone must be not empty";
                            }
                            return null;
                          },
                          controller: phoneController,
                          preIcon: const Icon(Icons.phone),
                          labelText: const Text("Phone"),
                        )
                      : cardInSitting(
                          prefixIcon: Icons.phone,
                          text: "${cubit.data!.phone}"),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ShopAppCubit.get(context).isEdit
                      ? defaultElevatedButton(
                          pressed: () {
                            if (formKey.currentState!.validate()) {
                              ShopAppCubit.get(context).upDateProfile(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                              );
                            }
                          },
                          text: "done")
                      : defaultElevatedButton(
                          pressed: () {
                            logOut(context: context);
                          },
                          text: "logout")
                ],
              ),
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
