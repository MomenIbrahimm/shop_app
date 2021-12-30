import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/state.dart';
import 'package:shop_app/modules/profile/profile_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class ChangePassScreen extends StatelessWidget {
  var currentController = TextEditingController();
  var newController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopGeneralCubit,ShopGeneralStates>(
      listener: (context,state){
        if(state is ShopChangePassSuccessState)
          {
            showToast(text:ShopGeneralCubit.get(context).changePassModel!.message, state: ToastStates.success);
            navigateTo(context, const ProfileScreen());
          }else{
          showToast(text: ShopGeneralCubit.get(context).changePassModel!.message, state: ToastStates.error);
        }
      },
      builder: (context,state){
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    clipping(
                        text: 'keep you password safe,', text2: 'change password'),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          IconlyLight.arrowLeft2,
                          color: Colors.white,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: double.infinity,
                    height: 250.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: LinearGradient(colors: [
                          Colors.grey.withOpacity(0.2),
                          Colors.grey.withOpacity(0.5),
                        ])),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          defaultTextFormField(
                            text: 'Current password',
                            controller: currentController,
                            textColor: Colors.black,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defaultTextFormField(
                            text: 'New password',
                            controller: newController,
                            textColor: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                defaultButton(
                    text: 'Change',
                    function: () {
                      ShopGeneralCubit.get(context).changePassword(
                          currentPass: currentController.text,
                          newPass: newController.text);
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
