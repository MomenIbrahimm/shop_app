import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/layout_screen.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/const.dart';
import 'package:shop_app/shared/network/local.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ShopLogCubit()),
        BlocProvider(create: (BuildContext context) => ShopGeneralCubit()..getProfile()),
      ],
      child: BlocConsumer<ShopLogCubit, ShopLogStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {

            if (state.logModel.status) {
              CacheHelper.saveData(
                  key: 'token',
                  value: state.logModel.data!.token
              )
                  .then((value) {
                token = state.logModel.data!.token!;
                navigateAndFinish(context, const LayoutScreen());
              });

            } else {
              Fluttertoast.showToast(
                  msg:state.logModel.message.toString(),
                fontSize: 16,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                 timeInSecForIosWeb: 1
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    ClipPath(
                      clipper: ClippingClass(),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                HexColor('113CFC'),
                                HexColor('1597E5'),
                              ]),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0, left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Welcome back,',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Log In!',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: defaultTextFormField(
                        controller: emailController,
                        text: 'Email',
                        validateText: 'please inter your email',
                        prefix: const Icon(Icons.email),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: defaultTextFormField(
                            controller: passController,
                            text: 'Password',
                            validateText: 'please inter your password',
                            prefix: const Icon(IconlyLight.password),
                            obscure: ShopLogCubit.get(context).isShow,
                            suffix: ShopLogCubit.get(context).icon,
                            suffixFunction: () {
                              ShopLogCubit.get(context).changeVisibility();
                            })),
                    const SizedBox(
                      height: 20,
                    ),
                    BuildCondition(
                      condition: state is! ShopLoginLoadingState,
                      builder: (context) => defaultButton(
                          text: 'Login',
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ShopLogCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passController.text);
                            }
                          }),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have any account? "),
                        defaultTextButton(
                            text: 'Register',
                            function: () {
                              navigateTo(context, const RegisterScreen());
                            })
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstControlPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
