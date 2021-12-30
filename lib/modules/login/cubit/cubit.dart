import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shop_app/model/shop_model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote.dart';

class ShopLogCubit extends Cubit<ShopLogStates> {
  ShopLogCubit() : super(ShopInitialState());

  static ShopLogCubit get(context) => BlocProvider.of(context);

  ShopUserLogModel? logModel ;

  bool isShow = true;
  IconData icon = IconlyLight.show;

  void changeVisibility() {
    isShow = !isShow;
    icon = isShow ? IconlyLight.show : IconlyLight.hide;
    emit(ChangeVisibilityState());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());

    DioHelper.postData(url: login, data: {
      'email': email,
      'password': password,
    }).then((value) {
      logModel = ShopUserLogModel.fromJson(value.data);
      emit(ShopLoginSuccessState(logModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }
}


//ShopUserLogModel(
//     data: UserData(
//         image: '',
//         phone: '',
//         name: '',
//         email: '',
//         credit: 0,
//         id: 0,
//         points: 0,
//         token: ''),
//     message: '',
//     status: false,
//   );