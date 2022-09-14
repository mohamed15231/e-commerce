
import '../../../models/login_shop_model.dart';

abstract class RegisterShopStates{}

class InitialRegisterState extends RegisterShopStates{}
class LoadingRegisterState extends RegisterShopStates{}
class SuccessRegisterState extends RegisterShopStates{
  final LogInModel loginModel;
  SuccessRegisterState(this.loginModel);

}
class ErrorRegisterState extends RegisterShopStates{
  String error;
  ErrorRegisterState(this.error);


}
class ChangeRegisterIcon extends RegisterShopStates{}

