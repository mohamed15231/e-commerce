import 'package:mealapp/models/favorites.dart';

import '../../models/login_shop_model.dart';

abstract class ShopAppStates{}

class InitialShopAppState extends ShopAppStates{}

class ChangeNavBarState extends ShopAppStates{}

class LoadingHomePageState extends ShopAppStates{}

class SuccessHomePageState extends ShopAppStates{}

class ErrorHomePageState extends ShopAppStates{}

class SuccessCategoryState extends ShopAppStates{}

class ErrorCategoryState extends ShopAppStates{}

class SuccessFavoriteState extends ShopAppStates{
  FavoriteModel favoriteModel;
  SuccessFavoriteState(this.favoriteModel);

}

class SuccessState extends ShopAppStates{}

class ErrorFavoriteState extends ShopAppStates{}

class GetFavoriteLoadingState extends ShopAppStates{}

class GetFavoriteSuccessState extends ShopAppStates{}

class GetFavoriteErrorState extends ShopAppStates{}

class GetProfileLoadingState extends ShopAppStates{}

class GetProfileSuccessState extends ShopAppStates{}

class GetProfileErrorState extends ShopAppStates{}

class ChangeEditState extends ShopAppStates{}

class UpDateLoadingState extends ShopAppStates{}

class UpDateSuccessState extends ShopAppStates{
  final LogInModel profile;

  UpDateSuccessState(this.profile);
}

class UpDateErrorState extends ShopAppStates{}
class NotDoneState extends ShopAppStates{}
class DoneState extends ShopAppStates{}


