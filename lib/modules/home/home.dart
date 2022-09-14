import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mealapp/layout/cubit/cubit.dart';
import 'package:mealapp/layout/cubit/states.dart';
import 'package:mealapp/modules/home/component_home.dart';
import 'package:mealapp/shared/components/components/components.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if(state is SuccessFavoriteState){
          if(state.favoriteModel.status==false){
            toastShow(state: ToastState.ERROR,text: state.favoriteModel.message);
          }
        }

      },
      builder: (context, state) {
        return ConditionalBuilderRec(
          condition: ShopAppCubit.get(context).homePage != null &&
              ShopAppCubit.get(context).category != null,
          builder: (context) => homePageShop(
            context: context,
              model: ShopAppCubit.get(context).homePage!,
              dataList: ShopAppCubit.get(context).category!),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }


}
