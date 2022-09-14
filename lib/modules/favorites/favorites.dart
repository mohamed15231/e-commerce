import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealapp/layout/cubit/states.dart';
import 'package:mealapp/models/get_favorite_model.dart';
import 'package:mealapp/shared/components/components/components.dart';

import '../../layout/cubit/cubit.dart';
import '../../style/colors.dart';

class Favorite extends StatelessWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopAppCubit.get(context);
        return ConditionalBuilderRec(
          condition: state is! GetFavoriteLoadingState,
          builder: (context) =>  ListView.separated(
            itemBuilder: (context, index) => buildFavoriteAndSearchPage(
                model: cubit.getFavList.data.dataProduct[index].product,
                context: context,
                isSearch: false,

            ),
            separatorBuilder: (context, index) => Container(
              height: 1,
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
            ),
            itemCount:cubit.getFavList.data.dataProduct.length ,
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }


}
