import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/state.dart';


class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopGeneralCubit, ShopGeneralStates>(
      listener: (context, state) {},
      builder: (context, state) {

        return SafeArea(
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: const
              [
                BottomNavigationBarItem(icon: Icon(IconlyLight.home),label: 'Home'),
                BottomNavigationBarItem(icon: Icon(IconlyLight.bag2),label: 'Products'),
                BottomNavigationBarItem(icon: Icon(IconlyLight.star),label: 'Favourites'),
              ],
              onTap: (index){
              ShopGeneralCubit.get(context).changeBottomNav(index);
              },
              currentIndex: ShopGeneralCubit.get(context).currentIndex,
            ),
            backgroundColor: Colors.grey[100],
            body: ShopGeneralCubit.get(context).screens[ShopGeneralCubit.get(context).currentIndex]
          ),
        );
      },
    );
  }


}
