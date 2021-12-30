import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/state.dart';
import 'package:shop_app/modules/all_offers/all_offer_screen.dart';
import 'package:shop_app/modules/category/category_screen.dart';
import 'package:shop_app/modules/product_details/product_details_screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/modules/setting/setting_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopGeneralCubit, ShopGeneralStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopGeneralCubit.get(context).homeModel;
        var categoryModel = ShopGeneralCubit.get(context).categoryModel;

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    BuildCondition(
                      condition: model != null,
                      builder: (context) => CarouselSlider(
                        items: ShopGeneralCubit.get(context)
                            .homeModel!
                            .data!
                            .banners
                            .map(
                              (e) => Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage('${e.image}'),
                                        fit: BoxFit.cover),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(50),
                                      bottomRight: Radius.circular(50),
                                    )),
                              ),
                            )
                            .toList(),
                        options: CarouselOptions(
                          height: 250,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: false,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration: const Duration(seconds: 1),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      fallback: (context) => Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  navigateTo(context, const SettingScreen());
                                },
                                child: IconButton(
                                    onPressed: () {
                                      navigateTo(
                                          context, const SettingScreen());
                                    },
                                    icon: const Icon(
                                      IconlyBold.setting,
                                      size: 30.0,
                                      color: Colors.lightBlue,
                                    )),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              navigateTo(context, const SearchScreen());
                            },
                            child: Container(
                              height: 40.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(7.5),
                              ),
                              child: Row(
                                children: const [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Search',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Spacer(),
                                  Icon(
                                    IconlyLight.search,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      defaultAddressText(text: 'Last Offers'),
                      const Spacer(),
                      SizedBox(
                          height: 32,
                          child: defaultTextButton(
                              text: 'All Offers',
                              function: () {
                                navigateTo(context, const AllOfferScreen());
                              })),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: 160,
                    child: BuildCondition(
                      condition:
                          ShopGeneralCubit.get(context).homeModel != null,
                      builder: (context) => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              navigateTo(
                                  context,
                                  ProductDetailsScreen(
                                    index: index,
                                  ));
                            },
                            child:
                                buildProductsItem(model!.data!.product[index])),
                        itemCount: 5,
                      ),
                      fallback: (context) => Container(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      defaultAddressText(text: 'Category'),
                      const Spacer(),
                      SizedBox(
                          height: 32,
                          child: defaultTextButton(
                              text: 'All Categories',
                              function: () {
                                navigateTo(context, const CategoryScreen());
                              })),
                    ],
                  ),
                ),
                BuildCondition(
                  condition: categoryModel != null,
                  builder: (context) => ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              navigateTo(context, const CategoryScreen());
                            },
                            child: buildCategoryItems(
                                categoryModel!.data!.dataModel[index]),
                          ),
                      separatorBuilder: (context, index) => const Divider(
                            color: Colors.grey,
                          ),
                      itemCount: 2),
                  fallback: (context) => Container(),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildCategoryItems(model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SizedBox(
        height: 65.0,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 2.5,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(model.image),
                ),
              ),
              const SizedBox(
                width: 2.5,
              ),
              Text(model.name),
              const Spacer(),
              IconButton(
                  onPressed: () {}, icon: const Icon(IconlyLight.arrowRight2))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProductsItem(model) {
    Widget widget = Container(
      width: 120,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
      child: Card(
        elevation: 2.5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  height: 90,
                  width: 120,
                  fit: BoxFit.contain,
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
                  )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                model.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 2.5,
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
                if (model.discount > 0)
                  defaultOldPriceText(text: '\$${model.oldPrice}'),
              ],
            ),
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
