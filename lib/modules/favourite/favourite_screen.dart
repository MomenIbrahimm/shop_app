import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/state.dart';
import 'package:shop_app/shared/components/components.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopGeneralCubit, ShopGeneralStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopGeneralCubit.get(context).getFavouritesModel;

        return Scaffold(
          appBar: AppBar(
            title: const Text('My Favourite'),
          ),
          body: BuildCondition(
            condition: model != null,
            builder: (context) => ListView.builder(
                itemBuilder: (context, index) =>
                    buildFavItem(model!.data!.data![index].product, context),
                itemCount: model!.data!.data!.length),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildFavItem(model, context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
        child: Card(
          elevation: 5.5,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image(
                      image: model.image != null
                          ? NetworkImage('${model.image}')
                          : const NetworkImage(
                              'https://img.freepik.com/free-vector/elegant-white-background-with-shiny-lines_1017-17580.jpg?size=626&ext=jpg&ga=GA1.2.1979218069.1628380800'),
                      height: 110,
                      width: 140,
                      fit: BoxFit.contain,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: 40,
                        height: 12.0,
                        color: Colors.red,
                        child: const Text(
                          'discount',
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    '${model.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        '${model.price}',
                        style: TextStyle(color: Colors.black.withOpacity(.8)),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    defaultOldPriceText(text: '${model.oldPrice}'),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          ShopGeneralCubit.get(context)
                              .changeIconFavourite(model.id);
                        },
                        icon: ShopGeneralCubit.get(context)
                                    .listFavourite[model.id] ==
                                true
                            ? const Icon(IconlyBold.star)
                            : const Icon(IconlyLight.star))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
