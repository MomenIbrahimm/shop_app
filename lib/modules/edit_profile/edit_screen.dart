import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/state.dart';
import 'package:shop_app/modules/change_password/change_pass_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class EditScreen extends StatelessWidget {

  EditScreen({Key? key}) : super(key: key);

  var nameController= TextEditingController();
  var emailController= TextEditingController();
  var phoneController= TextEditingController();
  var formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopGeneralCubit, ShopGeneralStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopGeneralCubit.get(context).userModel;

        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        var profileImage = ShopGeneralCubit.get(context).profileImage;

        return Scaffold(
          body: BuildCondition(
            condition: state is! ShopUpdateLoadingState,
            builder: (context) => SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        clipping(
                            text: 'Edit your info,', text2: 'Editing profile info'),
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
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              const CircleAvatar(
                                radius: 63.0,
                                backgroundColor: Colors.white,
                              ),
                               Padding(
                                padding: const EdgeInsets.all(2.9),
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: profileImage == null ?
                                      const NetworkImage('https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png')
                                      :
                                      FileImage(profileImage) as ImageProvider
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    ShopGeneralCubit.get(context).getProfileImage();
                                  },
                                  icon: const Icon(
                                    IconlyBold.camera,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: defaultTextFormField(
                                text: 'name',
                              controller: nameController,
                              prefix: const Icon(IconlyLight.profile),
                              validateText: 'name can not be empty',
                            ),
                          ),
                          const SizedBox(height: 10.0,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: defaultTextFormField(
                                text: 'email',
                              controller: emailController,
                              prefix: const Icon(Icons.email),
                              validateText: 'email can not be empty',
                            ),
                          ),
                          const SizedBox(height: 10.0,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: defaultTextFormField(
                                text: 'phone',
                              controller: phoneController,
                              prefix: const Icon(IconlyLight.call),
                              validateText: 'phone can not be empty',
                            ),
                          ),
                          SizedBox(height: 35.0,child: defaultTextButton(text: 'change password', function: (){
                            navigateTo(context, ChangePassScreen());
                          })),

                        ],
                      ),
                    ),
                    const SizedBox(height: 15.0,),
                    defaultButton(text: 'Update', function: (){
                      if(formKey.currentState!.validate())
                        {
                          ShopGeneralCubit.get(context).updateData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                    }),
                  ],
                ),
              ),
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
