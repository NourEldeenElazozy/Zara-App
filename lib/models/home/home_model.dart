class HomeModel {
  List<Products> products;
  HomeModel({this.products});

  HomeModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {

      products = <Products>[];

      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Products {
  int id;
  String name;
  bool inCart;
  bool infavorites;
  String imageUrl;
  dynamic price;
  dynamic oldPrice;
  int quantity;
  String description;
  int discount;
  int categoryId;
  String category;
  String favoriteId;
  String favorite;
  List<Images>images;

  Products(
      {this.id,
        this.name,
        this.inCart,
        this.infavorites,
        this.imageUrl,
        this.price,
        this.oldPrice,
        this.quantity,
        this.description,
        this.discount,
        this.categoryId,
        this.category,
        this.favoriteId,
        this.favorite,
        this.images});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    inCart = json['inCart'];
    infavorites = json['infavorites'];
    imageUrl = json['imageUrl'];
    price = json['price'];
    oldPrice = json['oldPrice'];
    quantity = json['quantity'];
    description = json['description'];
    discount = json['discount'];
    categoryId = json['categoryId'];
    category = json['category'];
    favoriteId = json['favoriteId'];
    favorite = json['favorite'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['inCart'] = this.inCart;
    data['infavorites'] = this.infavorites;
    data['imageUrl'] = this.imageUrl;
    data['price'] = this.price;
    data['oldPrice'] = this.oldPrice;
    data['quantity'] = this.quantity;
    data['description'] = this.description;
    data['discount'] = this.discount;
    data['categoryId'] = this.categoryId;
    data['category'] = this.category;
    data['favoriteId'] = this.favoriteId;
    data['favorite'] = this.favorite;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int id;
  String imageUrl;
  int productId;

  Images({this.id, this.imageUrl, this.productId});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['productId'] = this.productId;
    return data;
  }
}