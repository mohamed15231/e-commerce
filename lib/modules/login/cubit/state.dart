
import '../../../models/login_shop_model.dart';

abstract class LoginShopStates{}

class InitialLoginState extends LoginShopStates{}
class LoadingLoginState extends LoginShopStates{}
class SuccessLoginState extends LoginShopStates{
  final LogInModel loginModel;
  SuccessLoginState(this.loginModel);

}
class ErrorLoginState extends LoginShopStates{
  String error;
  ErrorLoginState(this.error);


}
class ChangeIcon extends LoginShopStates{}

