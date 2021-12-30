import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/layout/cubit/state.dart';
import 'package:shop_app/model/category_model.dart';
import 'package:shop_app/model/change_pass_model.dart';
import 'package:shop_app/model/contact_model.dart';
import 'package:shop_app/model/favourite_model.dart';
import 'package:shop_app/model/get_favourite_model.dart';
import 'package:shop_app/model/search_model.dart';
import 'package:shop_app/model/setting_model.dart';
import 'package:shop_app/model/shop_home_model.dart';
import 'package:shop_app/model/shop_model.dart';
import 'package:shop_app/modules/favourite/favourite_screen.dart';
import 'package:shop_app/modules/home/home_screen.dart';
import 'package:shop_app/modules/product/product_screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/const.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote.dart';

class ShopGeneralCubit extends Cubit<ShopGeneralStates> {
  ShopGeneralCubit() : super(ShopInitialGeneralState());

  static ShopGeneralCubit get(context) => BlocProvider.of(context);

  ShopHomeModel? homeModel;

  Map<int, bool> listFavourite = {};

  List<Widget> screens = [
    const HomeScreen(),
    const ProductScreen(),
    FavouriteScreen(),
  ];

  int currentIndex = 0;

  void changeBottomNav(index) {
    currentIndex = index;
    emit(ChangeBottomNav());
  }

  void getHomeData() {
    emit(ShopGetHomeDataLoadingState());

    DioHelper.getData(url: home, token: token).then((value) {
      homeModel = ShopHomeModel.fromJson(value.data);

      for (var element in homeModel!.data!.product) {
        listFavourite.addAll({element.id: element.inFavourite});
      }
      emit(ShopGetHomeDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetHomeDataErrorState());
    });
  }

  CategoryModel? categoryModel;

  void getCategoryData() {
    emit(ShopGetCategoryDataLoadingState());

    DioHelper.getData(
      url: categories,
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(ShopGetCategoryDataSuccessState());
    }).catchError((error) {
      emit(ShopGetCategoryDataErrorState());
    });
  }

  ShopUserLogModel? userModel;

  void getProfile() {
    emit(ShopGetProfileLoadingState());

    DioHelper.getData(
      url: profile,
      token: token,
    ).then((value) {
      userModel = ShopUserLogModel.fromJson(value.data);
      emit(ShopGetProfileSuccessState());
    }).catchError((error) {
      emit(ShopGetProfileErrorState());
    });
  }

  bool isFavourite = false;
  IconData iconFavourite = IconlyLight.star;

  FavouriteModel? favouriteModel;

  void changeIconFavourite(int productId) {
    listFavourite[productId] == false
        ? listFavourite[productId] = true
        : listFavourite[productId] = false;
    emit(ShopChangeFavouriteSuccessState());
    DioHelper.postData(
        url: favorites,
        token: token,
        data: {'product_id': productId}).then((value) {
      favouriteModel = FavouriteModel.fromJson(value.data);
      getFavData();
      emit(ShopChangeFavouriteSuccessState());
    }).catchError((error) {
      emit(ShopChangeFavouriteErrorState());
    });
  }

  GetFavouritesModel? getFavouritesModel;

  void getFavData() {
    DioHelper.getData(
      url: favorites,
      token: token,
    ).then((value) {
      getFavouritesModel = GetFavouritesModel.fromJson(value.data);
      emit(ShopGetFavouriteSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetFavouriteSuccessState());
    });
  }

  ContactModel? contactModel;

  void getContact() {
    emit(ShopGetContactsLoadingState());

    DioHelper.getData(
      url: contacts,
    ).then((value) {
      contactModel = ContactModel.fromJson(value.data);
      emit(ShopGetContactsSuccessState());
    }).catchError((error) {
      emit(ShopGetContactsErrorState());
    });
  }

  SettingsModel? settingsModel;

  void getAbout() {
    emit(ShopGetAboutLoadingState());

    DioHelper.getData(url: settings).then((value) {
      settingsModel = SettingsModel.fromJson(value.data);
      emit(ShopGetAboutSuccessState());
    }).catchError((error) {
      emit(ShopGetAboutErrorState());
    });
  }

  ShopUserLogModel? updateModel;

  void updateData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopUpdateLoadingState());

    DioHelper.putData(url: updateProfile, token: token, data: {
      "name": name,
      "email": email,
      "phone": phone,
    }).then((value) {
      updateModel = ShopUserLogModel.fromJson(value.data);
      emit(ShopUpdateSuccessState());
      getProfile();
    }).catchError((error) {
      emit(ShopUpdateErrorState());
    });
  }

  // File? image;
  // final picker = ImagePicker();
  //

  // Future getImageFromGallery() async{
  //   final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if(pickedImage != null)
  //   {
  //     image = File(pickedImage.path);
  //   }
  //   else{
  //     print('NO image selected');
  //   }
  // }

// Future getImageFromCamera() async{
//   final pickedImage= await picker.pickImage(source: ImageSource.camera);
//
//   if(pickedImage != null)
//     {
//       image = pickedImage.path as File;
//     }
//   else{
//     print('NO image selected');
//   }
// }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ShopProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(ShopProfileImagePickedErrorState());
    }
  }

  ChangePassModel? changePassModel;

  void changePassword({
    required String currentPass,
    required String newPass,
  }) {
    emit(ShopChangePassLoadingState());

    DioHelper.postData(
        url: changePass,
        token: token,
        data: {
      "current_password": currentPass,
      "new_password": newPass,
    }).then((value) {
      changePassModel = ChangePassModel.fromJson(value.data);
      emit(ShopChangePassSuccessState());
    }).catchError((error) {
      emit(ShopChangePassErrorState());
    });
  }

  SearchModel? searchModel;
  List<SearchModel> listSearch=[];

  void search({
  required String text
}){

    DioHelper.postData(
        url: productsSearch,
        data: {
          "text" : text
        }
    ).then((value){
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel!.data!.data![0].name);
      emit(ShopSearchSuccessState());
    }).catchError((error){
      emit(ShopSearchErrorState());
    });
  }
}
