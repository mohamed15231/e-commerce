import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealapp/layout/cubit/cubit.dart';
import 'package:mealapp/layout/cubit/states.dart';
import 'package:mealapp/modules/login/log%20in.dart';
import 'package:mealapp/modules/search/search_screen.dart';
import 'package:mealapp/shared/components/components/components.dart';
import 'package:mealapp/shared/network/cachehelper.dart';

import '../../style/colors.dart';

class ShopLayOut extends StatelessWidget {
  const ShopLayOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopAppCubit()
        ..getHomePage()
        ..getCategory()
        ..getFavorite()
        ..getProfile(),
      child: BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopAppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Shop App",
              ),
              actions:  [
                IconButton(onPressed: () {
                  navigateTo(context: context, page:  SearchScreen());
                }, icon: const Icon(Icons.search))
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps_outlined), label: "Category"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: "Favorite"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: "Setting"),
              ],
              currentIndex: cubit.currentIndex,
              onTap: (value) {
                cubit.changeNavBar(currentIndex: value);
              },
            ),
            body: cubit.screen[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
