import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/state.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopGeneralCubit,ShopGeneralStates>(
     listener: (context,state){},
     builder: (context,state){
       var model = ShopGeneralCubit.get(context).contactModel;

       return Scaffold(
         appBar: AppBar(),
         body: Padding(
           padding: const EdgeInsets.all(20.0),
           child: BuildCondition(
             condition: model != null ,
             builder: (context) => ListView.separated(
                 itemBuilder: (context,index)=>buildContactItem(model!.data!.data![index]),
                 separatorBuilder: (context,index)=> const SizedBox(height:20.0,),
                 itemCount: model!.data!.data!.length
             ),
             fallback: (context) => const Center(child: CircularProgressIndicator()) ,
           ),
         ),
       );
     },
    );
  }
  Widget buildContactItem(model){
    return Row(
      children:
      [
        CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.black87.withOpacity(0.7),
          child: Image(image: NetworkImage(model.image)),
        ),
        const SizedBox(width: 20,),
        Text(model.value),
      ],
    );
  }
}
