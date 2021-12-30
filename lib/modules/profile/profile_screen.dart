import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/state.dart';
import 'package:shop_app/modules/edit_profile/edit_screen.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopGeneralCubit, ShopGeneralStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopGeneralCubit.get(context).userModel;
        var profileImage = ShopGeneralCubit.get(context).profileImage;

        if (profileImage != null) {
          model!.data!.image = '$profileImage';
        }

        return Scaffold(
          body: SingleChildScrollView(
            child: BuildCondition(
              condition: model != null,
              builder: (context) => Column(
                children: [
                  Stack(
                    children: [
                      clipping(text: 'look at your info,', text2: 'My Profile'),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            IconlyLight.arrowLeft2,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Colors.white,
                      Colors.grey.withOpacity(.5),
                    ])),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5.0,
                        ),
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: profileImage != null
                              ? NetworkImage('${FileImage(profileImage)}')
                              : const NetworkImage(
                                  'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png'),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              const Text(
                                'ID: ',
                                style:
                                    TextStyle(color: Colors.black, fontSize: 17),
                              ),
                              Text(
                                '${model!.data!.id}',
                                style: const TextStyle(
                                    color: Colors.blue, fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              const Text(
                                'Name: ',
                                style:
                                    TextStyle(color: Colors.black, fontSize: 17),
                              ),
                              Text(
                                '${model.data!.name}',
                                style: const TextStyle(
                                    color: Colors.blue, fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              const Text(
                                'Email: ',
                                style:
                                    TextStyle(color: Colors.black, fontSize: 17),
                              ),
                              Text(
                                '${model.data!.email}',
                                style: const TextStyle(
                                    color: Colors.blue, fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              const Text(
                                'Phone: ',
                                style:
                                    TextStyle(color: Colors.black, fontSize: 17),
                              ),
                              Text(
                                '${model.data!.phone}',
                                style: const TextStyle(
                                    color: Colors.blue, fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: defaultButton(
                              text: 'Sign Out',
                              function: () {
                                CacheHelper.removeData(key: 'token')
                                    .then((value) {
                                  navigateTo(context, LoginScreen());
                                });
                              }),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: IconButton(
                          onPressed: () {
                            navigateTo(context, EditScreen());
                          },
                          icon: const Icon(
                            IconlyLight.edit,
                            color: Colors.blue,
                          ),
                        )),
                      ],
                    ),
                  )
                ],
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }
}
