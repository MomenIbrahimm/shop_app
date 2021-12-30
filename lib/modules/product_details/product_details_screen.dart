import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/state.dart';

class ProductDetailsScreen extends StatelessWidget {
  final index;

  const ProductDetailsScreen({this.index});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopGeneralCubit, ShopGeneralStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopGeneralCubit.get(context).homeModel!.data!.product;

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    Container(
                        height: 220,
                        width: double.infinity,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.grey.withOpacity(0.2),
                                Colors.grey.withOpacity(0.1),
                              ]),
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(50.0),
                              bottomLeft: Radius.circular(50.0)),
                        ),
                        child: Image(
                            height: 200,
                            image: NetworkImage(model[index].image))),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 5.0),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            IconlyLight.arrowLeft2,
                            color: Colors.lightBlue,
                            size: 30,
                          )),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 20.0, left: 20.0, top: 25.0, bottom: 5.0),
                  child: Text(
                    model[index].name,
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Text(
                        '\$${model[index].price}',
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      if (model[index].discount != 0)
                        Text(
                          '\$${model[index].oldPrice}',
                          style:
                              const TextStyle(fontSize: 13, color: Colors.grey,decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                        icon: ShopGeneralCubit.get(context)
                            .listFavourite[model[index].id] ==
                            true
                            ? const Icon(IconlyBold.star)
                            : const Icon(IconlyLight.star),
                        onPressed: () {
                          ShopGeneralCubit.get(context)
                              .changeIconFavourite(model[index].id);
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.all(20.0),
                  child: Text(
                    model[index].description,
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
