import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealapp/layout/cubit/cubit.dart';
import 'package:mealapp/models/get_favorite_model.dart';
import 'package:mealapp/models/search_model.dart';
import 'package:mealapp/modules/search/cubit/state.dart';
import 'package:mealapp/shared/components/constant/constant.dart';
import 'package:mealapp/shared/endpoints.dart';
import 'package:mealapp/shared/network/dio.dart';

class SearchCubit extends Cubit<SearchScreenStates> {
  SearchCubit() : super(InitialSearchState());
  static SearchCubit get(context)=>BlocProvider.of(context);

  SearchModel? search;
  void postSearchScreen({
    required String text,
  }) {
    emit(LoadingSearchState());
    DioHelper.postData(
      url: SEARCH,
      data: {'text': text},
      token: token,
    ).then((value) {
      search=SearchModel.json(value.data);
      print(search!.data!.data);
      emit(SuccessSearchState());
    }).catchError((error){
      print(error);
      emit(ErrorSearchState());

    });
  }
}
