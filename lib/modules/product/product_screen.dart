import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/state.dart';
import 'package:shop_app/modules/product_details/product_details_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopGeneralCubit, ShopGeneralStates>(
      listener: (context, state) {
        if (state is ShopChangeFavouriteSuccessState) {
          showToast(text: 'Done',
              state: ToastStates.success);
        }
      },
      builder: (context, state) {
        var model = ShopGeneralCubit
            .get(context)
            .homeModel;

        return Scaffold(
            backgroundColor: Colors.grey[200],
            body: BuildCondition(
              condition: model != null ,
              builder: (context)=>Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'Click on the item what you want to show it details,And you can click on the star to add the item in your favourite.',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(
                          fontSize: 13, color: Colors.black.withOpacity(0.6)),
                    ),
                    Expanded(
                      child: InkWell(
                        child: GridView.builder(
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                          itemBuilder: (context, index) =>
                              InkWell(
                                  onTap: () {
                                    navigateTo(
                                        context,
                                        ProductDetailsScreen(
                                          index: index,
                                        ));
                                  },
                                  child: buildGridView(
                                      model!.data!.product[index], context)),
                          itemCount: model!.data!.product.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (context)=>const Center(child: CircularProgressIndicator()),
            )
        );
      },
    );
  }

  Widget buildGridView(model, context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Card(
          elevation: 5,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            children: [
              Image(
                image: model.image != null
                    ? NetworkImage('${model.image}')
                    : const NetworkImage(
                    'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAA+VBMVEX//////v///vz///vZ3N/+/fr6+vjn7fLC0+S1yt2VutN7pcVpnMJwoMWNr86sydzb4+qowtdqoMNJjr4AbLAAZKwAX6sAU6EAYaFQfLN6jq/Bucr78/LJ1eB7p84YeLYHVpu1w9WjssnH1NpAbKY8ZKhEYZ+LgqPX0d9pjLR/mLlPcauSorqQpMQ1XqI/XKRjaoI4aJg+cqYRRHhRbpVIZY9jfJ8oSoIfTns4VoBzhKAjOWWutb5BUXHO0dJod41OXXozSGxyfZCKk6MoNE1FSmAOI0oWLVIhOFwAF0W3vcV2fYoACTkAJkUAIk0AAStgZnJxdH44P1ZCjhUmAAABPUlEQVR4nO3V6VLTYBSA4SSNBGWxCm3ZirhQEbfIUlkCRVsSSaEi938xDlyBP8pkzDzPzPf/PXPmmxMEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP+/6OGFVWc8nkYURlHwpOqMxxE2ZpLZp8/m5hcWn88m4cM2ayUMmi9eLi23Wu12Z2V1bX2jdhM2upuvWu2t13H3zdt329u99zt1G7G5uNzpbHU+7H7c/fS596X3NW02qm6aru63vbX9g8P+96P+0fHJ8Un/NKs6acri9Ox8kJYX2Y80+zkcZOmorDppysLsMi8mk+K0yIv8V3E1GiY1+4hRWI5H11c3N3k+mVz/vs02anj3k3I4/nN5d3c7Hpdx/e5hEN6vLInjZhzHwf1Oqw6Cf/YXJekbSALNXJkAAAAASUVORK5CYII='),
                height: 100,
                width: 120,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  '${model.name}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 2.5,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      '\$${model.price}',
                      style: TextStyle(color: Colors.black.withOpacity(.8)),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if (model.discount != 0)
                    defaultOldPriceText(text: '\$${model.oldPrice}'),
                ],
              ),
            ],
          ),
        ),
        if (model.discount != 0)
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
          ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: IconButton(
              onPressed: () {
                ShopGeneralCubit.get(context).changeIconFavourite(model.id);
              },
              icon:
              ShopGeneralCubit
                  .get(context)
                  .listFavourite[model.id] == true
                  ? const Icon(IconlyBold.star)
                  : const Icon(IconlyLight.star)),
        )
      ],
    );
  }
}
