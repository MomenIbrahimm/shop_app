import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/state.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var searchController = TextEditingController();

    return BlocConsumer<ShopGeneralCubit,ShopGeneralStates>(
      listener: (context,state){},
      builder: (context,state){
        var model = ShopGeneralCubit.get(context).searchModel;

        return Scaffold(
          appBar: AppBar(
            leading:  IconButton(
              icon:const Icon(IconlyLight.arrowLeft2),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultTextFormField(
                    controller: searchController,
                    text: 'Search',
                    textColor: Colors.black,
                    suffix: IconlyLight.search,
                    suffixColor: Colors.black,
                    suffixFunction: (){
                      ShopGeneralCubit.get(context).search(text: searchController.text);
                    },
                ),
                const SizedBox(height: 10.0,),
                BuildCondition(
                  condition: model != null,
                  builder: (context) => Expanded(
                    child: ListView.builder(
                      itemBuilder: (context,index)=>buildSearchItem(model!.data!.data![index],context),
                      itemCount: model!.data!.data!.length,
                    ),
                  ),
                  fallback: (context) => Container() ,
                )
              ],
            ),
          ),
        );
      },
    );
  }
  Widget buildSearchItem(model,context){
    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 105.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                      image: DecorationImage(
                        image: model.image != null
                            ? NetworkImage(model.image)
                            : const NetworkImage(
                            'https://m.media-amazon.com/images/I/51UW1849rJL._AC_SY355_.jpg'),
                      )),
                ),
                if(model.discount != 0)
                  Container(
                  width: 50,
                  height: 10,
                  color: Colors.red,
                  child: const Text(
                    'discount %',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                )
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    model.name,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      // Text('\$${model.price}'),
                      const SizedBox(
                        width: 20,
                      ),
                      // defaultOldPriceText(text: '\$${model.oldPrice}'),
                      const Spacer(),
                      IconButton(
                        icon: ShopGeneralCubit.get(context)
                            .listFavourite[model.id] ==
                            true
                            ? const Icon(IconlyBold.star)
                            : const Icon(IconlyLight.star),
                        onPressed: () {
                          ShopGeneralCubit.get(context)
                              .changeIconFavourite(model.id);
                        },
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
