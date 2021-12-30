import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/register/cubit.dart';
import 'package:shop_app/modules/register/states.dart';
import 'package:shop_app/shared/components/components.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passController = TextEditingController();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();

    return  Scaffold(
      body: BlocProvider(
        create: (BuildContext context)=> ShopRegisterCubit(),
        child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
          listener: (context,state){},
          builder: (context,state){
            return  SingleChildScrollView(
              child: Column(
                children: [
                  clipping(text:'Hello,',text2: 'Sign Up!' ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: defaultTextFormField(
                      validateText: 'please inter your name',
                      controller: nameController,
                      text: 'Name',
                      prefix: const Icon(Icons.person),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: defaultTextFormField(
                      validateText: 'please inter your email',
                      controller: emailController,
                      text: 'Email',
                      prefix: const Icon(Icons.email),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: defaultTextFormField(
                        controller: passController,
                        validateText: 'please inter your password',
                        text: 'Password',
                        prefix: const Icon(IconlyLight.password),
                        suffix: IconlyLight.show,
                        suffixFunction: () {}),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: defaultTextFormField(
                      validateText: 'please inter your phone',
                      controller: phoneController,
                      text: 'Phone',
                      prefix: const Icon(IconlyLight.call),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultButton(text: 'Sign Up', function: () {
                    ShopRegisterCubit.get(context).userRegister(
                      name: nameController.text,
                      email: emailController.text,
                      password: passController.text,
                      phone: phoneController.text,
                    );
                    navigateAndFinish(context, LoginScreen());
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      defaultTextButton(
                          text: 'Sign in',
                          function: () {
                            navigateTo(context, LoginScreen());
                          })
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
