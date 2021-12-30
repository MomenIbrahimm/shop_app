import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/shop_model.dart';
import 'package:shop_app/modules/register/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopUserLogModel? logModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(
        url: register,
        data: {
          'name' : name,
          'email' : email,
          'password' : password,
          'phone' : phone,
        },
    ).then((value){
      logModel = ShopUserLogModel.fromJson(value.data);
      emit(ShopRegisterSuccessState());
    }).catchError((error){
      emit(ShopRegisterErrorState());
    });
  }
}