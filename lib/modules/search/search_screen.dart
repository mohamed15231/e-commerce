import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealapp/layout/cubit/cubit.dart';
import 'package:mealapp/modules/search/cubit/cubit.dart';
import 'package:mealapp/modules/search/cubit/state.dart';
import 'package:mealapp/shared/components/components/components.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
  var searchController=TextEditingController();
  var formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext ctx) {
    return MultiBlocProvider(
      providers: [BlocProvider(
        create: (context) => ShopAppCubit(),
      ),
      BlocProvider(create: (context) => SearchCubit(),)
      ],
      child: BlocConsumer<SearchCubit,SearchScreenStates>(
          listener: (ctx, state) {
          },
          builder: (ctx, state) {
            var cubit=SearchCubit.get(ctx);
            return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  defaultTextForm(preIcon: const Icon(Icons.search),
                      labelText:const Text("search"),
                      typeKeyboard: TextInputType.text,
                      controller: searchController,
                      validate: (value) {
                        if(value!.isEmpty){
                          return "value must be not empty";
                        }
                        return null;

                      },
                      submit: (value){
                        SearchCubit.get(ctx).postSearchScreen(text: searchController.text);
                      }
                  ),
                  if(state is SuccessSearchState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (ctx, index) => buildFavoriteAndSearchPage(
                            model: cubit.search!.data!.data![index],
                            context: ctx,
                            isSearch: true,
                        ),
                        separatorBuilder: (ctx, index) => Container(
                          height: 1,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                          ),
                        ),
                        itemCount: cubit.search!.data!.data!.length ,
                      ),
                    ),
                ],

              ),
            )
            ,
          );
          },
        )
      ,
    );
  }
}
