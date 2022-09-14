import 'package:flutter/material.dart';
import 'package:mealapp/layout/cubit/cubit.dart';
import 'package:mealapp/models/category_model.dart';
import 'package:mealapp/modules/categories/component_catogory.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildCategoriesScreen(
          ShopAppCubit.get(context).category!.data!.data![index]),
      separatorBuilder: (context, index) => Container(
        color: Colors.grey[400],
        height: 1,
      ),
      itemCount: ShopAppCubit.get(context).category!.data!.data!.length,
    );
  }

}
