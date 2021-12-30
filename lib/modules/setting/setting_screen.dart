import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/state.dart';
import 'package:shop_app/modules/contact/contact_screen.dart';
import 'package:shop_app/modules/profile/profile_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopGeneralCubit,ShopGeneralStates>(
      listener: (context,state){},
      builder: (context,state){
        var model = ShopGeneralCubit.get(context).settingsModel;

        return  BuildCondition(
          condition: model != null,
          builder: (context) => Scaffold(
            body: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        clipping(text: 'Hey!', text2: 'Settings'),
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
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: InkWell(
                        onTap: () {
                          navigateTo(context, const ProfileScreen());
                        },
                        child: Row(
                          children: const [
                            Icon(
                              IconlyLight.profile,
                              size: 25.0,
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              'My account',
                              style: TextStyle(fontSize: 20.0, color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                      child: InkWell(
                        onTap: () {
                          navigateTo(context, const ContactScreen());
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.contacts_outlined,
                              size: 25.0,
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              'Contacts',
                              style: TextStyle(fontSize: 20.0, color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text('About:',style: TextStyle(fontSize: 18.0),),
                    ),
                    model!.data!.about != null? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('${model.data!.about}'),
                    ):const Text(''),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }
}
