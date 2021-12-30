import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/state.dart';
import 'package:shop_app/modules/product_details/product_details_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class AllOfferScreen extends StatelessWidget {
  const AllOfferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopGeneralCubit, ShopGeneralStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopGeneralCubit.get(context).homeModel;

        return Scaffold(
          appBar: AppBar(
            title: const Text('All offers'),
          ),
          body: BuildCondition(
            condition: model != null,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.separated(
                itemBuilder: (context, index) =>
                    InkWell(onTap: (){
                      navigateTo(context, ProductDetailsScreen(index: index));
                    },child: buildProductsItem(model!.data!.product[index], context)),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 5,
                ),
                itemCount: model!.data!.product.length,
              ),
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildProductsItem(model, context) {
    Widget widget = Padding(
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
                      Text('\$${model.price}'),
                      const SizedBox(
                        width: 20,
                      ),
                      defaultOldPriceText(text: '\$${model.oldPrice}'),
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

    if (model.discount > 0) {
      return widget;
    }
    return Container();
  }
}
