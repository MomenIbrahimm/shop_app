class ShopHomeModel {
   bool? status;
   HomeDataModel? data;

  // ShopHomeModel({required this.data, required this.status});

  ShopHomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
   List<BannersModel> banners = [];
   List<ProductModel> product= [];

  // HomeDataModel({required this.banners, required this.product});

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannersModel.fromJson(element));
    });

    json['products'].forEach((element) {
      product.add(ProductModel.fromJson(element));
    });
  }
}

class BannersModel {
   int? id;
   String? image;

  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;
  late bool inFavourite;
  late bool inCart;

  // ProductModel(
  //     {required this.id,
  //     required this.image,
  //     required this.name,
  //     required this.description,
  //     this.discount,
  //     required this.inCart,
  //     required this.inFavourite,
  //     required this.oldPrice,
  //     this.price
  //     });

  //named Constructor
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavourite = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
