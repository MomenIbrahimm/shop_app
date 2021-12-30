import 'package:shop_app/model/shop_model.dart';

abstract class ShopLogStates {}

class ShopInitialState extends ShopLogStates{}

class ChangeVisibilityState extends ShopLogStates{}

class ShopLoginLoadingState extends ShopLogStates{}

class ShopLoginSuccessState extends ShopLogStates{
  final ShopUserLogModel logModel ;

  ShopLoginSuccessState(this.logModel);
}

class ShopLoginErrorState extends ShopLogStates{
  final String error;
  ShopLoginErrorState(this.error);
}

