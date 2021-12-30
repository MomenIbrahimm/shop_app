import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/state.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopGeneralCubit, ShopGeneralStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopGeneralCubit.get(context).categoryModel;

        return Scaffold(
            appBar: AppBar(
              title: const Text('All Categories'),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(IconlyLight.arrowLeft2),
              ),
            ),
            body: ListView.separated(
                itemBuilder: (context, index) => InkWell(
                    onTap: () {},
                    child: buildCategoryItem(model!.data!.dataModel[index])),
                separatorBuilder: (context, index) => const Divider(
                      color: Colors.grey,
                    ),
                itemCount: model!.data!.dataModel.length));
      },
    );
  }

  Widget buildCategoryItem(model) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 110,
            height: 90,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.contain, image: NetworkImage(model.image)),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              model.name,
              style: const TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
